# Webtrends
[![Gem Version](https://badge.fury.io/rb/webtrends.png)](http://badge.fury.io/rb/webtrends)
[![Code Climate](https://codeclimate.com/github/amaabca/webtrends.png)](https://codeclimate.com/github/amaabca/webtrends)
[![Build Status](https://travis-ci.org/amaabca/webtrends.png?branch=master)](https://travis-ci.org/amaabca/webtrends)
[![Coverage Status](https://coveralls.io/repos/amaabca/webtrends/badge.png)](https://coveralls.io/r/amaabca/webtrends)
[![Dependency Status](https://gemnasium.com/amaabca/webtrends.png)](https://gemnasium.com/amaabca/webtrends)

Make use of the Webtrends api to post event data for analytics purposes.

## Installation

Add this line to your application's Gemfile:

    gem 'webtrends'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install webtrends

## Usage

Create config/initializers/webtrends.rb

Add the following configuration block

    Webtrends.configure do |c|
      c.protocol = 'https'
      c.domain = 'dc.webtrends.com'
      c.version = 'v1'
      c.customer_id = YOUR_CUSTOMER_ID
      c.verbose = true (setting verbose false is recommended in production)
      c.format = 'xml' (plain or xml)
    end

Additional documentation can be found on: http://help.webtrends.com/en/dcapi/

Example:

     wt = Webtrends::Event.new(tags: { dcsuri: '/your_path_to_track', 'WT.ti' => 'a_tag'} )
     response = wt.track

Note: You will either get a RestClient::Response back or an exception will be raised.

Note: dcsuri is required for the constructor.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Create tests for your feature
4. Make sure coverage meets minimum requirements
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request