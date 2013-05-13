require 'gotta_bench_em_all'

module GottaBenchEmAll

  # TODO export to gem
  class Ab

    require 'gotta_bench_em_all/ab/option'

    BIN = 'ab'

    DEFAULT_OPTIONS = { }

    attr_reader :url, :options

    # XXX use Ruby 2.0 keyword arguments when Ruby 1.9 goes out (probably when I will be dead)
    def initialize(url, options = {})
      @url = url
      @options = Hash[ DEFAULT_OPTIONS.merge(options).map{ |name, values| to_option!(name, *values) } ]
    end
    
    def command
      "#{BIN} #{options.map(&:to_s).join(' ')}"
    end

    def run
      `#{command}`
    end

    private
    
    def to_option!(name, *values)
      Option.new(name, *values)
    rescue ArgumentError
      raise ArgumentError, "#{name} is not a valid Ab option"
    end
    
  end

end