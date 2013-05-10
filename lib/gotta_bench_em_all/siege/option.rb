require 'gotta_bench_em_all'
require 'gotta_bench_em_all/siege'
require 'shellwords'

module GottaBenchEmAll

  # TODO export to gem
  class Siege

    class Option

      SCHEME = { version:               [ :unary  , '--version'    ] ,
                 configuration:         [ :unary  , '--config'     ] ,
                 verbose:               [ :unary  , '--verbose'    ] ,
                 get:                   [ :unary  , '--get'        ] ,
                 concurrent_requests:   [ :binary , '--concurrent' ] ,
                 internet:              [ :unary  , '--internet'   ] ,
                 delay:                 [ :binary , '--delay'      ] ,
                 benchmark:             [ :unary  , '--benchmark'  ] ,
                 repetitions:           [ :binary , '--reps'       ] ,
                 time:                  [ :binary , '--time'       ] ,
                 log_file:              [ :binary , '--log'        ] ,
                 log_file_entries_mark: [ :binary , '--mark'       ] ,
                 header:                [ :binary , '--header'     ] ,
                 siegerc_file:          [ :binary , '--rc'         ] ,
                 urls_file:             [ :binary , '--file'       ] ,
                 user_agent:            [ :binary , '--user-agent' ] }.freeze

      attr_reader   :name
      attr_accessor :value

      def initialize(name, value = nil)
        @name, @value = name.to_sym, value
        type_check
      end

      def type
        @type ||= SCHEME.fetch(@name)[0]
      end

      def option
        @option ||= SCHEME.fetch(@name)[1]
      end

      def to_s
        case type
        when :unary
          option
        when :binary
          value_to_s = value.to_s
          value_to_s == '' ? option : "#{option}={value_to_s.shellescape}"
        end
      end

      private
      
      def type_check
        type
      rescue KeyError
        raise ArgumentError, "#{@name} is not a valid Siege option"        
      end

    end

  end

end