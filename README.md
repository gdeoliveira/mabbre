# MAbbre

[![Gem Version](http://img.shields.io/gem/v/mabbre.svg)][gem]
[![Build Status](http://img.shields.io/travis/gdeoliveira/mabbre.svg)][travis]
[![Code Climate](http://img.shields.io/codeclimate/github/gdeoliveira/mabbre.svg)][codeclimate]
[![Test Coverage](http://img.shields.io/codeclimate/coverage/github/gdeoliveira/mabbre.svg)][codeclimate]
[![Dependency Status](http://img.shields.io/gemnasium/gdeoliveira/mabbre.svg)][gemnasium]
[![Inline docs](http://inch-ci.org/github/gdeoliveira/mabbre.svg?branch=master)][inch-ci]

[gem]: https://rubygems.org/gems/mabbre
[travis]: http://travis-ci.org/gdeoliveira/mabbre
[codeclimate]: https://codeclimate.com/github/gdeoliveira/mabbre
[gemnasium]: https://gemnasium.com/gdeoliveira/mabbre
[inch-ci]: http://inch-ci.org/github/gdeoliveira/mabbre

MAbbre allows a group of methods in a Class or a Module to be accessed using an abbreviated form. These methods can be defined anywhere within a hierarchy of inclusion and/or inheritance.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "mabbre"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mtrack

## Usage

Step 1: Define methods within an `allow_abbreviated` block in a Class or a Module:

```ruby
module M
  extend MAbbre::Mixin
  allow_abbreviated do
    def very_long_method
      "This method has a very long name."
    end
  end
end

class C
  include M
  allow_abbreviated do
    def another_long_method
      "Another method with a long name."
    end
  end
end

class D < C
  allow_abbreviated do
    def yet_another_long_method
      "Yet another looong method name."
    end
  end
end
```

Step 2: Call these methods using a shortened name!

```ruby
o = D.new
o.very     #=> "This method has a very long name."
o.another  #=> "Another method with a long name."
o.yet      #=> "Yet another looong method name."
```

## Contributing

1. Fork it ( https://github.com/gdeoliveira/mabbre/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
