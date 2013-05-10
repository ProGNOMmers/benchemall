require 'gotta_bench_em_all'
require 'gotta_bench_em_all/ab'
require 'shellwords'

module GottaBenchEmAll

  # TODO export to gem
  class Ab

    class Option

      SCHEME = { authentication:        [ 2 , 'A' ] ,
                 windowsize:            [ 1 , 'b' ] ,
                 concurrency:           [ 1 , 'c' ] ,
                 windowsize:            [ 2 , 'C' ] ,
                 windowsize:            [ 0 , 'd' ] ,
                 windowsize:            [ 1 , 'e' ] ,
                 windowsize:            [ 1 , 'f' ] ,
                 windowsize:            [ 1 , 'g' ] ,
                 windowsize:            [ 1 , 'H' ] ,
                 windowsize:            [ 0 , 'i' ] ,
                 windowsize:            [ 0 , 'k' ] ,
                 windowsize:            [ 1 , 'n' ] ,
                 windowsize:            [ 1 , 'p' ] ,
                 windowsize:            [ 2 , 'P' ] ,
                 windowsize:            [ 0 , 'q' ] ,
                 windowsize:            [ 0 , 'r' ] ,
                 windowsize:            [ 0 , 's' ] ,
                 windowsize:            [ 0 , 'S' ] ,
                 windowsize:            [ 1 , 't' ] ,
                 windowsize:            [ 1 , 'T' ] ,
                 windowsize:            [ 1 , 'u' ] ,
                 windowsize:            [ 1 , 'v' ] ,
                 windowsize:            [ 0 , 'V' ] ,
                 windowsize:            [ 0 , 'w' ] ,
                 windowsize:            [ 1 , 'x' ] ,
                 windowsize:            [ 2 , 'X' ] ,
                 windowsize:            [ 1 , 'y' ] ,
                 windowsize:            [ 1 , 'z' ] ,
                 windowsize:            [ 1 , 'Z' ] ,

      attr_reader   :name
      attr_accessor :value

      def initialize(name, value = nil)
        @name, @value = name.to_sym, value
        validate!
      end

      def arguments_number
        @arguments_number ||= SCHEME[@name][0]
      end

      def option
        @option ||= SCHEME[@name][1]
      end

      def to_s
        case arguments_number
        when 0
          option
        when 1
          value_to_s = value.to_s
          value_to_s == '' ? option : "#{option}={value_to_s.shellescape}"
        end
      end

      private
      
      def validate!
        raise ArgumentError, "#{@name} is not a valid Ab option" unless SCHEME.keys.include? @name
      end

    end

  end

end