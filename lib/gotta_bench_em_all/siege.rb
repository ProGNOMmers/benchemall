require 'gotta_bench_em_all'

module GottaBenchEmAll

  # TODO export to gem
  class Siege

    require 'gotta_bench_em_all/siege/option'

    DEFAULT_OPTIONS = { version:               Option.new( :unary,  false ),
                        configuration:         Option.new( :unary,  nil   ), 
                        verbose:               Option.new( :unary,  false ), 
                        get:                   Option.new( :unary,  false ), 
                        concurrent_requests:   Option.new( :binary, 10    ), 
                        internet:              Option.new( :unary,  false ), 
                        delay:                 Option.new( :binary, 0     ), 
                        benchmark:             Option.new( :unary,  false ),
                        repetitions:           Option.new( :binary, 1     ),
                        time:                  Option.new( :binary, nil   ),
                        log_file:              Option.new( :binary, nil   ),
                        log_file_entries_mark: Option.new( :binary, nil   ),
                        header:                Option.new( :binary, nil   ),
                        siegerc_file:          Option.new( :binary, nil   ),
                        urls_file:             Option.new( :binary, nil   ),
                        user_agent:            Option.new( :binary, nil   )}

    # XXX use Ruby 2.0 keyword arguments when Ruby 1.9 goes out
    def initialize(*options)
      options = values.extract_options!
      name = options.fetch(:name, 'default')
    end
    
    def run

    end
    
  end

end