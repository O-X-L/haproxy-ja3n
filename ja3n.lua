-- Source: https://github.com/O-X-L/haproxy-ja3n
-- Copyright (C) 2024 Rath Pascal
-- License: MIT

-- JA3N = sorted extensions to tackle browsers randomizing their order
-- see: https://tlsfingerprint.io/norm_fp
-- examples:
--   before (JA3): 771,4865-4867-4866-49195-49199-52393-52392-49196-49200-49162-49161-49171-49172-156-157-47-53,0-23-65281-10-11-16-5-34-51-43-13-45-28-65037-41,29-23-24-25-256-257,0
--   after (JA3N): 771,4865-4867-4866-49195-49199-52393-52392-49196-49200-49162-49161-49171-49172-156-157-47-53,0-10-11-13-16-23-28-34-41-43-45-5-51-65037-65281,29-23-24-25-256-257,0
-- usage:
--   register: lua-load /etc/haproxy/lua/ja3n.lua (in global)
--   run: http-request lua.fingerprint_ja3n
--   log: http-request capture var(txn.fingerprint_ja3n) len 32
--   acl: var(txn.fingerprint_ja3n) -m str a195b9c006fcb23ab9a2343b0871e362

local function split_string(str, delimiter)
    local result = {}
    local from  = 1
    local delim_from, delim_to = string.find(str, delimiter, from)
    while delim_from do
        table.insert(result, string.sub(str, from , delim_from-1))
        from  = delim_to + 1
        delim_from, delim_to = string.find(str, delimiter, from)
    end
    table.insert(result, string.sub(str, from))
    return result
end

function fingerprint_ja3n(txn)
    local p1 = tostring(txn.f:ssl_fc_protocol_hello_id())
    local p2 = tostring(txn.c:be2dec(txn.f:ssl_fc_cipherlist_bin(1), '-', 2))

    local p3u = tostring(txn.c:be2dec(txn.f:ssl_fc_extlist_bin(1), '-', 2))
    local p3l = split_string(p3u, '-')
    table.sort(p3l)
    local p3 = table.concat(p3l, '-')

    local p4 = tostring(txn.c:be2dec(txn.f:ssl_fc_eclist_bin(1),'-',2))
    local p5 = tostring(txn.c:be2dec(txn.f:ssl_fc_ecformats_bin(),'-',1))

    local fingerprint = p1 .. ',' .. p2 .. ',' .. p3 .. ',' .. p4 .. ',' .. p5
    local fingerprint_hash = string.lower(tostring(txn.c:hex(txn.c:digest(fingerprint, 'md5'))))

    txn:set_var('txn.fingerprint_ja3n_raw', fingerprint)
    txn:set_var('txn.fingerprint_ja3n', fingerprint_hash)
end

core.register_action('fingerprint_ja3n', {'tcp-req', 'http-req'}, fingerprint_ja3n)
