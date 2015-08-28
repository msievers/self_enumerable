# SelfEnumerable

## Usage

```ruby
require "self_enumerable"

class DataSet
  include SelfEnumerable
  
  # constructor needs to be able to handle array parameter
  def initialize(values = [])
    @values = values
  end
  
  def each
    return enum_for(__method__) unless block_given?
    
    @values.each do |value|
      yield value
    end
  end
end

data_set = DataSet.new([1,2,3,4,5])

#
# instead of returning plain arrays, instances of objects class are returned
#

data_set.select { |element| element < 3 }
# => #<DataSet:0x00000000f0f0a0 @values=[1, 2]>

data_set.partition { |element| element <= 3 }
# =>  [#<DataSet:0x00000000ed2c40 @values=[1, 2, 3]>, #<DataSet:0x00000000ed2c18 @values=[4, 5]>]
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'self_enumerable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install self_enumerable

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/msievers/self_enumerable.

