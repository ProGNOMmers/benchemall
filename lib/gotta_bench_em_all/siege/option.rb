require 'gotta_bench_em_all'
require 'gotta_bench_em_all/siege'

module GottaBenchEmAll

  # TODO export to gem
  class Siege

    class Option
      attr_reader   :type
      attr_accessor :value
      def initialize(type, value)
        @type, @default_value = type, value
      end
    end

  end

end