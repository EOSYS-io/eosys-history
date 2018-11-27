# README

## Dependencies
- Ruby 2.5.1 - https://gorails.com/setup/osx/10.13-high-sierra#ruby
- Openssl >= 1.0.1 supporting TLS 1.X (X >= 1)
To see the version of openssl
```
$ openssl version
```
Or check TLS version with ruby
```
$ ruby -e "require 'net/http'; require 'json'; puts JSON.parse(Net::HTTP.get(URI('https://www.howsmyssl.com/a/check')))['tls_version']"
```


## Setup
```
$ gem install bundler
$ bundle install
```

## Run

```
$ puma
```
