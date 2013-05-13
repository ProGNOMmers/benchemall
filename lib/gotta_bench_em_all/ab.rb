require 'gotta_bench_em_all'

module GottaBenchEmAll

  # TODO export to gem
  class Ab

    require 'gotta_bench_em_all/ab/option'

    BIN = 'ab'

    # DEFAULT_OPTIONS = {}

    attr_reader :url, :options

    # XXX use Ruby 2.0 keyword arguments when Ruby 1.9 goes out (probably when I will be dead)
    def initialize(url, options = {})
      @url = url
      # @options = DEFAULT_OPTIONS.merge(options).map{ |name, values| to_option!(name, *values) }
      @options = options.map{ |name, values| to_option!(name, *values) }
    end
    
    def to_a
      [ BIN ].push( *options.map(&:to_a).flatten ).push url.to_s
    end

    def to_s
      to_a.map(&:shellescape).join(' ')
    end

    private
    
    def to_option!(name, *values)
      Option.new(name, *values)
    rescue ArgumentError
      raise ArgumentError, "#{name} is not a valid Ab option"
    end
    
  end

end