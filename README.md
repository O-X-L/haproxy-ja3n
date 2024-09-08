# HAProxy - JA3N TLS Client-Fingerprint - Lua Plugin

## Intro

About JA3:
* [Salesforce Repository](https://github.com/salesforce/ja3)
* [HAProxy Enterprise JA3 Fingerprint](https://customer-docs.haproxy.com/bot-management/client-fingerprinting/tls-fingerprint/)
* [Why JA3 broke => JA3N](https://github.com/salesforce/ja3/issues/88)

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
* Load the LUA module by adding `lua-load /etc/haproxy/lua/ja3n.lua` in the `global` section
* Execute the LUA script on HTTP requests: `http-request lua.fingerprint_ja3n`
* Log the fingerprint: `http-request capture var(txn.fingerprint_ja3n) len 32`

----

## Contribute

If you have:

* Found an issue/bug - please [report it](https://github.com/O-X-L/haproxy-ja3n/issues/new)
* Have an idea on how to improve it - [feel free to start a discussion](https://github.com/O-X-L/haproxy-ja3n/discussions/new/choose)
* PRs are welcome

### Testing

* Run: `bash test/run.sh`
* Access the test website: https://localhost:6969/

Exit with `CTRL+C`
