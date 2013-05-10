require 'gotta_bench_em_all'
require 'gotta_bench_em_all/siege'

module GottaBenchEmAll
  class Benchmark
    def initialize
      
    end

    def run

      Siege.new().run

      #siege -b -c 8 -r 10000 -l$HOME/siege.log -m 'Rails - Passenger'   http://127.0.0.1:3000/hello/world
    end
    
  end
end