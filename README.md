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

### Mac OS X

You'll need a copy of [libusb](http://www.libusb.org/) and its development library installed.

One easy way to do this is with [homebrew](http://mxcl.github.com/homebrew/):

    brew install libusb

### Linux

You need a copy of [libusb](http://www.libusb.org/)'s development libraries.'

### Windows

WARNING: I only use Windows at work. I don't own a personal copy and therefore
don't use it.  However, my goal is to make this work on Windows with the help
of people like you.  So find me on [http://freenode.net/] IRC as `docwhat` or
via [docwhat.org](http://docwhat.org) if you have problems. Or file an issue!

The [libusb](https://github.com/larskanis/libusb) gem has support for windows
built in; it ships with a `libusb.dll` ready to use.

You may need a USB driver. I'm hopeful that if you installed the lego NXT-G
environment (the CD that came with Mindstorms) that you should be ready to go.
If not, read the [libusb](https://github.com/larskanis/libusb) gem's docs.
They suggest something called
[Zadig](http://sourceforge.net/apps/mediawiki/libwdi/index.php?title=Main_Page).

## Usage

TODO: Write usage instructions here

## Documentation

The documentation is written for yard. Install the `yard` gem and you can
use the `yri` command to browse the documentation.

Alternatively, you can read the [online documentation](http://rubydoc.info/github/docwhat/lego_nxt/master/frames).

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
