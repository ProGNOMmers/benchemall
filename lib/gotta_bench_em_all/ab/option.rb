require 'gotta_bench_em_all'
require 'gotta_bench_em_all/ab'
require 'shellwords'

module GottaBenchEmAll

  # TODO export to gem
  class Ab

    class Option

      SCHEME = { http_auth_credentials:      [ 'A' , 2 , ':' ] ,
                 tcp_window_size:            [ 'b' , 1       ] ,
                 concurrency:                [ 'c' , 1       ] ,
                 cookie:                     [ 'C' , 2 , '=' ] ,
                 hide_percentage:            [ 'd' , 0       ] ,
                 csv_file:                   [ 'e' , 1       ] ,
                 encryption_protocol:        [ 'f' , 1       ] ,
                 gnuplot_file:               [ 'g' , 1       ] ,
                 header:                     [ 'H' , 1       ] ,
                 head:                       [ 'i' , 0       ] ,
                 keep_alive:                 [ 'k' , 0       ] ,
                 requests:                   [ 'n' , 1       ] ,
                 post_data_file:             [ 'p' , 1       ] ,
                 proxy_auth_credentials:     [ 'P' , 2 , ':' ] ,
                 hide_progress_count:        [ 'q' , 0       ] ,
                 ignore_socket_errors:       [ 'r' , 0       ] ,
                 https:                      [ 's' , 0       ] ,
                 hide_stats:                 [ 'S' , 0       ] ,
                 time_limit:                 [ 't' , 1       ] ,
                 post_put_data_content_type: [ 'T' , 1       ] ,
                 put_data_file:              [ 'u' , 1       ] ,
                 verbosity:                  [ 'v' , 1       ] ,
                 version:                    [ 'V' , 0       ] ,
                 html_output:                [ 'w' , 0       ] ,
                 html_table_attributes:      [ 'x' , 1       ] ,
                 proxy:                      [ 'X' , 2 , ':' ] ,
                 html_tr_attributes:         [ 'y' , 1       ] ,
                 html_td_attributes:         [ 'z' , 1       ] ,
                 cipher_suite:               [ 'Z' , 1       ] }

      attr_reader   :name
      attr_accessor :values

      def initialize(name, *values)
        @name, @values = name.to_sym, values
        validate!
      end

      def option
        @option ||= SCHEME[@name][0]
      end

      def arguments_number
        @arguments_number ||= SCHEME[@name][1]
      end

      def arguments_separator
        @arguments_separator ||= SCHEME[@name][2]
      end

      def to_s
        case arguments_number
        when 0
          option
        when 1
          "#{option} {value[0].to_s.shellescape}"
        when 2
          "#{option} {value[0].to_s.shellescape}#{arguments_separator}{value[1].to_s.shellescape}"
        end
      end

      private
      
      def validate!
        raise ArgumentError, "#{@name} is not a valid Ab option" unless SCHEME.keys.include? @name
      end

    end

  end

end