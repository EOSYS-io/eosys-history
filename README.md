# README

## Dependencies
* Ruby 2.5.1 - https://gorails.com/setup/osx/10.13-high-sierra#ruby
* TLS 1.x (x >= 1) for Ruby Mongodb driver.
```
# In non-macOSX environment, openssl >= 1.0.1 supports TLS 1.X (X >= 1)
openssl version

# For macOSX users, check TLS version with ruby.
ruby -e "require 'net/http'; require 'json'; puts JSON.parse(Net::HTTP.get(URI('https://www.howsmyssl.com/a/check')))['tls_version']"
```


## Setup
```
gem install bundler
bundle install --binstubs
```

## Recommended VSCode settings.
```
# Add to settings.json
"editor.formatOnSave": true,
"editor.formatOnSaveTimeout": 5000,
"ruby.lint": {
  "reek": true,
  "rubocop": true,
  "ruby": true, // Runs ruby -wc
  "fasterer": true,
  "debride": true,
  "ruby-lint": true
},
"ruby.format": "rubocop",
"ruby.rubocop.executePath": "./bin/rubocop",
```

## Run

```
bin/puma
```

## Test
```
bin/rspec
```

