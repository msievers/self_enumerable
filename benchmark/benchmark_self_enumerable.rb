#!/usr/bin/env ruby

require "bundler/setup"
require "self_enumerable"

class BenchmarkSelfEnumerable
  class DataSet
    def initialize(values)
      @values = values
    end

    def each
      return enum_for(__method__) unless block_given?

      @values.each do |_value|
        yield _value
      end
    end
  end

  class EnumerableDataSet < DataSet
    include Enumerable
  end

  class SelfEnumerableDataSet < DataSet
    include SelfEnumerable
  end

  def call
    require "benchmark/ips"

    values = [1,2,3,4,5,6,7,8,9,10]

    enumerable_data_set = EnumerableDataSet.new(values)
    self_enumerable_data_set = SelfEnumerableDataSet.new(values)

    Benchmark.ips do |x|
      callable = -> (_el) { _el }

      x.report("Enumerable#map") do
        enumerable_data_set.map(&callable)
      end

      x.report("SelfEnumerable#map") do
        self_enumerable_data_set.map(&callable)
      end

      x.compare!
    end
  end
end
  
BenchmarkSelfEnumerable.new.call
