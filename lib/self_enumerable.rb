require "self_enumerable/version"

module SelfEnumerable
  WRAPPED_METHODS = [
    :collect, :collect_concat, :drop, :drop_while, :first, :find_all,
    :grep, :max, :min, :min_by, :partition, :reject, :select, :sort, :sort_by,
    :take, :take_while
  ] # map/flat_map are disabled because its often used to map something into another format

  def self.included(klass)
    klass.class_eval <<-eoruby
      include Enumerable
    eoruby

    # for every Enumerable method, e.g. #map, #select ...
    Enumerable.public_instance_methods.each do |_enum_method|
      if WRAPPED_METHODS.include?(_enum_method)
        if _enum_method == :partition # some special handling is needed
          klass.class_eval <<-eoruby
            def #{_enum_method}(*)
              (result = super).is_a?(Array) ? [self.class.new(result[0]), self.class.new(result[1])] : result
            end
          eoruby
        else
          klass.class_eval <<-eoruby
            def #{_enum_method}(*)
              (result = super).is_a?(Array) ? self.class.new(result) : result
            end
          eoruby
        end
      end
    end
  end
end
