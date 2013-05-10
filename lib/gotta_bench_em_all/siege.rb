require 'gotta_bench_em_all'

module GottaBenchEmAll

  # TODO export to gem
  class Siege

    require 'gotta_bench_em_all/siege/option'

    BIN = 'siege'

    DEFAULT_OPTIONS = { version:               false ,
                        configuration:         nil   ,
                        verbose:               false ,
                        get:                   false ,
                        concurrent_requests:   10    ,
                        internet:              false ,
                        delay:                 0     ,
                        benchmark:             false ,
                        repetitions:           1     ,
                        time:                  nil   ,
                        log_file:              nil   ,
                        log_file_entries_mark: nil   ,
                        header:                nil   ,
                        siegerc_file:          nil   ,
                        urls_file:             nil   ,
                        user_agent:            nil   }

    attr_reader :options

    # XXX use Ruby 2.0 keyword arguments when Ruby 1.9 goes out (probably before then I will be dead)
    def initialize(options = {})
      @options = Hash[ DEFAULT_OPTIONS.merge(options).map{ |name, value| to_option!(name, value) } ]
    end
    
    def command
      "#{BIN} #{options.map(&:to_s).join(' ')}"
    end

    def run
      `#{command}`
    end

    private
    
    def to_option!(name, value)
      Option.new(name, value)
    rescue ArgumentError
      raise ArgumentError, "#{name} is not a valid Siege option"
    end
    
  end

end