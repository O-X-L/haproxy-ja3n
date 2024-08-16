# HAProxy - JA3N Client-Fingerprint - Lua Plugin

**WARNING: This plugin is still in early development! DO NOT USE IN PRODUCTION!**

## Intro

About JA3:
* [Salesforce Repository](https://github.com/salesforce/ja3)
* [HAProxy Enterprise JA3 Fingerprint](https://customer-docs.haproxy.com/bot-management/client-fingerprinting/tls-fingerprint/)
* [JA3N](https://tlsfingerprint.io/norm_fp)

### NEW: JA4

About JA4:

* [HAProxy Lua Plugin](https://github.com/O-X-L/haproxy-ja4)
* [FoxIO Repository](https://github.com/FoxIO-LLC/ja4)
* [Cloudflare Blog](https://blog.cloudflare.com/ja4-signals)
* [FoxIO Blog](https://blog.foxio.io/ja4%2B-network-fingerprinting)
* [FoxIO JA4 Database](https://ja4db.com/)

----

## Usage

* Add the LUA script `ja3n.lua` to your system

## Config

* Enable SSL/TLS capture with the global setting [tune.ssl.capture-buffer-size 96](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#tune.ssl.capture-buffer-size)
* Load the LUA module with `lua-load /etc/haproxy/lua/ja3n.lua`
* Execute the LUA script on HTTP requests: `http-request lua.fingerprint_ja3n`
* Log the fingerprint: `http-request capture var(txn.fingerprint_ja3n) len 32`

----

## Contribute

If you have:

* Found an issue/bug - please [report it](https://github.com/O-X-L/haproxy-ja3n/issues/new)
* Have an idea on how to improve it - [feel free to start a discussion](https://github.com/O-X-L/haproxy-ja3n/discussions/new/choose)
* PRs are welcome

### Testing

* Create snakeoil certificate:

  ```bash
  openssl req -x509 -newkey rsa:4096 -sha256 -nodes -subj "/CN=HAProxy JA3N Test" -addext "subjectAltName = DNS:localhost,IP:127.0.0.1" -keyout /tmp/haproxy.key.pem -out /tmp/haproxy.crt.pem -days 30
  cat /tmp/haproxy.crt.pem /tmp/haproxy.key.pem > /tmp/haproxy.pem
  ```

* Link the LUA script: `ln -s $(pwd)/ja3n.lua /tmp/haproxy_ja3n.lua`
* You can run the `haproxy_example.cfg` manually like this: `haproxy -W -f haproxy_example.cfg`
* Access the test website: https://localhost:6969/


```bash
127.0.0.1:35046 [16/Aug/2024:14:49:56.204] test_ja4~ test_ja4/<NOSRV> 0/-1/-1/-1/0 200 49 - - PR-- 1/1/0/0/0 0/0 {t13d1715h2_002f,0035,009c,009d,1301,1302,1303,c009,c00a,c013,c014,c02b,c02c,c02f,c030,cca8,cca9_0005,000a,000b,000d,0017,001c,0022,0029,002b,002d,0033,fe0d,ff01|t13d1715h2_4a3d28116287_c114573b7948|} "GET https://localhost:6969/ HTTP/2.0"
```
