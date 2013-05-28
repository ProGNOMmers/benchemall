require 'gotta_bench_em_all'
require 'uri'

module GottaBenchEmAll

  # TODO export to gem
  class Ab

    require 'gotta_bench_em_all/ab/option'

    BIN = 'ab'

    # DEFAULT_OPTIONS = {}

    attr_reader :url, :options

    # XXX use Ruby 2.0 keyword arguments when Ruby 1.9 goes out (probably when I will be dead)
    def initialize(url, options = {})
      url = URI.parse url.to_s

      # For some strange reason, ab doesn't like URLs without path; we add it if necessary
      if host_missing_and_path_without_slash(url)
        url.path << '/'
      elsif host_present_and_empty_path(url)
        url.path = '/'
      end

      @url = url
      
      # @options = DEFAULT_OPTIONS.merge(options).map{ |name, values| to_option!(name, *values) }
      @options = options.map{ |name, values| to_option!(name, *values) }
    end
    
    def to_a
      [ BIN, *options.map(&:to_a).flatten, url.to_s ]
    end

    def to_s
      to_a.map(&:shellescape).join(' ')
    end

    private

    def host_missing_and_path_without_slash(url)
      !url.host && url.path && !url.path.include?('/')
    end

    def host_present_and_empty_path(url)
      url.host && ( !url.path || url.path.empty? )
    end
    
    def to_option!(name, *values)
      Option.new(name, *values)
    rescue ArgumentError
      raise ArgumentError, "#{name} is not a valid Ab option"
    end
    
  end

end