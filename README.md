# LegoNxt

[![Build Status](https://secure.travis-ci.org/docwhat/lego_nxt.png?branch=master)](http://travis-ci.org/docwhat/lego_nxt)

An object oriented interface for talking to the LEGO NXT brick.

## Installation

Add this line to your application's Gemfile:

    gem 'lego_nxt'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lego_nxt

## Usage

TODO: Write usage instructions here

## Testing

Most tests will work without owning a NXT brick

To run all the tests, including the ones that require a NXT brick, then you need to
plugin your NXT brick, power it on, and set the environment variable `HAS_NXT` to
the value `true`.

Example:

    env HAS_NXT=true rspec spec

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Reference Material

Useful if you're going to be hacking on the code:

* [libusb](https://github.com/larskanis/libusb) - The [docs](http://rubydoc.info/gems/libusb/LIBUSB) in particular.
* [LEGO's Support Files](http://mindstorms.lego.com/en-us/support/files/default.aspx#Advanced) - In particular:
 * The Bluetooth Developer Kit -- Appendix 1: LEGO MINDSTORMS NXT Communication protocol
 * Software Development Kit -- The PDF contains a description of the Executable File Specification
