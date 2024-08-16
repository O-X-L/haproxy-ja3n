# HAProxy - JA3N TLS Client-Fingerprint - Lua Plugin

## Intro

About JA3:
* [Salesforce Repository](https://github.com/salesforce/ja3)
* [HAProxy Enterprise JA3 Fingerprint](https://customer-docs.haproxy.com/bot-management/client-fingerprinting/tls-fingerprint/)
* [JA3N](https://tlsfingerprint.io/norm_fp)

### NEW: JA4

About JA4:

* [HAProxy Lua Plugin](https://github.com/O-X-L/haproxy-ja4)
* [JA4+ Suite](https://github.com/FoxIO-LLC/ja4/blob/main/technical_details/README.md)
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
127.0.0.1:35898 [16/Aug/2024:16:09:43.216] test_ja4~ test_ja4/<NOSRV> 0/-1/-1/-1/0 200 49 - - PR-- 1/1/0/0/0 0/0 {771,4865-4867-4866-49195-49199-52393-52392-49196-49200-49162-49161-49171-49172-156-157-47-53,0-10-11-13-16-23-28-34-35-43-45-5-51-65037-65281,29-23-24-25-256-257,0|6de49ac34a6c56203da4665ceffb91c3} "GET https://localhost:6969/ HTTP/2.0"
```
