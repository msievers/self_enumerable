describe SelfEnumerable do
  it { is_expected.to be_a(Module) }

  context "if included into a class" do
    class ClassWhichIncludesSelfEnumerable
      include SelfEnumerable

      def initialize(value = nil, options = {})
        @result_set = value || default_value
      end

      def each
        return enum_for(__method__) unless block_given?

        @result_set.each do |_value|
          yield _value
        end
      end
    end

    let(:value_not_in_values) { 0 }
    let(:values) { [1,2,3] }

    describe "an instance of that class" do
      subject { ClassWhichIncludesSelfEnumerable.new(values) }

      context "in case the enumerable method would return an array" do
        # generic "take a block" methods
        [:collect, :drop_while, :find_all, :reject, :select, :sort_by, :take_while].each do |_method_name|
          describe "##{_method_name}" do
            it "should return an instance of its class" do
              expect(subject.send(_method_name) { |_el| true }).to be_an(ClassWhichIncludesSelfEnumerable)
            end
          end
        end

        # generic "take an integer" methods
        [:drop, :first, :max, :min, :take].each do |_method_name|
          describe "##{_method_name}" do
            it "should return an instance of its class" do
              expect(subject.send(_method_name, 1)).to be_an(ClassWhichIncludesSelfEnumerable)
            end
          end
        end

        # non-generic methods
        describe "#grep" do
          it "should return an instance of its class" do
            expect(subject.grep(//) { |_el| _el }).to be_an(ClassWhichIncludesSelfEnumerable)
            expect(subject.grep(//)).to be_an(ClassWhichIncludesSelfEnumerable)
          end
        end

        describe "#min_by" do
          it "should return an instance of its class" do
            expect(subject.min_by(2) { |_el| 0 }).to be_an(ClassWhichIncludesSelfEnumerable)
          end
        end

        describe "#partition" do
          it "should return an instance of its class" do
            expect(subject.partition { |_el| true }).to all(be_an(ClassWhichIncludesSelfEnumerable))
          end
        end

        describe "#sort" do
          it "should return an instance of its class" do
            expect(subject.sort).to be_an(ClassWhichIncludesSelfEnumerable)
            expect(subject.sort { |a,b| a <=> b }).to be_an(ClassWhichIncludesSelfEnumerable)
          end
        end
      end
    end
  end
end
