# Roku Packager

Roku Packager is a ruby library for uploading and packaging Roku
applications. Normally this interaction has to be done through the
clunky Roku web GUI. Given an installer enabled Roku and a compiled zip
of your code you can pass it to Roku Packager and it will return the url
to download the pkg file that is ready for upload to roku.com.

[![BuildStatus](https://travis-ci.org/brookemckim/roku-packager.png)](https://travis-ci.org/brookemckim/roku-packager)
[![CodeClimate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/brookemckim/roku-packager)



## Installation

Add this line to your application's Gemfile:

    gem 'roku-packager'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install roku-packager

## Usage

First you need a Roku in development mode on your network and a zip file of 
your Roku source file.  

Then you can instansiate a client.
```
ip_of_your_roku = '192.168.0.10'
roku = RokuPackager.new(ip_of_your_roku)

# Pass in a logger for inside information.
roku = RokuPackager.new(ip_of_your_roku, Logger.new(STDOUT))

# This may take a couple minutes. Generating the keys is the slowest part.
roku.package('application_name', '/path/to/roku/app.zip')
# => http://192.168.0.10/pkg/app.pkg
``` 

You can then download this package with your tool of choice.
```
wget http://192.168.0.10/pkg/app.pkg
```

Each part of the process can be used as a standalone piece.
```
# Generate DevID and Password.
dev_id, password = RokuPackager::KeyGen.new(ip_of_your_roku).create

# Upload application zip.
RokuPackager::Uploader.new(ip_of_your_roku).run('/path/to/app.zip')

# Package an uploaded application.
download_uri = RokuPackager::Packager.new(ip_of_your_roku, 'application_name',
password).submit
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
