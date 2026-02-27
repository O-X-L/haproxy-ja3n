# HAProxy - JA3N TLS Client-Fingerprint - Lua Plugin

----

Note: The HAProxy enterprise-edition has native JA3-support that will provide you better performance.

Test it: [fingerprint.oxl.app](https://fingerprint.oxl.app)

## Intro

About JA3:
* [Salesforce Repository](https://github.com/salesforce/ja3)
* [Why JA3 broke => JA3N](https://github.com/salesforce/ja3/issues/88)

### NEW: JA4

About JA4:

* [JA4+ Suite](https://github.com/FoxIO-LLC/ja4/blob/main/technical_details/README.md)
* [FoxIO Repository](https://github.com/FoxIO-LLC/ja4)
* [Cloudflare Blog](https://blog.cloudflare.com/ja4-signals)
* [FoxIO Blog](https://blog.foxio.io/ja4%2B-network-fingerprinting)
* [FoxIO JA4 Database](https://ja4db.com/)
* [JA4 HAProxy Lua Plugin](https://github.com/O-X-L/haproxy-ja4)
* [JA4H HAProxy Lua Plugin](https://github.com/O-X-L/haproxy-ja4h)

Browser Fingerprinting:
* [Browser Fingerprinting](https://github.com/O-X-L/browser-fingerprint)

----

## Usage

* Add the LUA script `ja3n.lua` to your system

## Config

* Enable SSL/TLS capture with the global setting [tune.ssl.capture-buffer-size 96](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#tune.ssl.capture-buffer-size)
* Load the LUA module by adding `lua-load /etc/haproxy/lua/ja3n.lua` in the `global` section
* Execute the LUA script on HTTP requests: `http-request lua.fingerprint_ja3n`
* Log the fingerprint: `http-request capture var(txn.fingerprint_ja3n) len 32`

----

## License

This script is licensed under the MIT-license and thus is free to use.

The JA3 algorithm is licensed under the `BSD 3-Clause` license and also free to use - see: [salesforce/ja3](https://github.com/salesforce/ja3/blob/master/LICENSE.txt)

----

## Contribute

If you have:

* Found an issue/bug - please [report it](https://github.com/O-X-L/haproxy-ja3n/issues/new)
* Have an idea on how to improve it - [feel free to start a discussion](https://github.com/O-X-L/haproxy-ja3n/discussions/new/choose)
* PRs are welcome

### Testing

* Run: `bash test/run.sh`
* Access the test website: https://localhost:6969/
* Or query the API: `curl -v https://localhost:6969/api`
  ```
  {
    "fingerprint": "845df01a87c23862312ff1a2756c3b26",
    "details": "771,4865-4866-4867-49195-49199-49196-49200-52393-52392-49171-49172-156-157-47-53,0-5-10-11-13-16-18-23-27-35-41-43-45-51-17613-65037-65281,4588-29-23-24,0"
  }
  ```

Exit with `CTRL+C`
