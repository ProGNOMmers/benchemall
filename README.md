Bench'em all!!!
===============

WORK IN PROGRESS - STAY OUT!!!
==============================

Preface
-------

My name is Maurizio De Santis, and I work as web developer in Rome. I use Ruby on Rails in my work since the 2.2 version.

As a Ruby developer I am aware the variety of Ruby application servers, and the difference they do in the publishing of a high-load web app: you couldhave to buy another couple of servers just for a bad application server choice.

At the moment there is quite a wide list of Ruby application servers used on production environments: [Thin](http://code.macournoyer.com/thin/), [Mongrel](http://mongrel.rubyforge.org), [Passenger](https://www.phusionpassenger.com/), [Unicorn](http://unicorn.bogomips.org/), [Puma](http://puma.io/)... each of them with its strengths and weaknesses: stable, easy/pain in the ass to install/configure/maintain, multithreading support, fast/slow, resources-freer/consumer, ... 

So when I saw the [link about the Passenger 4.1.0 release on Hacker News](https://news.ycombinator.com/item?id=5661874),I thought "Horray! This is the moment I waited for years! Let's bench'em all (the ones that are interesting to me - which are Passenger, Unicorn and Puma - if you are a fan of other app servers let me know!)!!!"

Hardware:
CPU: Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz (8 cores)
HD: WesternDigital Caviar Black 7200 RPM
Memory: Corsair DDR3 1333 MHz

Software:
Linux Ubuntu 13.04 64bit
Ruby 2.0.0p0 (CFLAGS="-march=native -03 -pipe")
Nginx 1.4.0 (installed and compiled by Passenger)
Passenger 4.0.1
Unicorn 4.6.2
Puma 2.0.1

```
unicorn -c config/unicorn.rb -D
puma -C config/puma.rb

siege -b -c 8 -r 10000 -l$HOME/siege.log -m 'Rails - Passenger'   http://127.0.0.1:3000/hello/world
siege -b -c 8 -r 10000 -l$HOME/siege.log -m 'Rails - Unicorn'     http://127.0.0.1:3001/hello/world
siege -b -c 8 -r 10000 -l$HOME/siege.log -m 'Rails - Puma'        http://127.0.0.1:3002/hello/world
siege -b -c 8 -r 10000 -l$HOME/siege.log -m 'Sinatra - Passenger' http://127.0.0.1:3003/
siege -b -c 8 -r 10000 -l$HOME/siege.log -m 'Sinatra - Unicorn'   http://127.0.0.1:3004/
siege -b -c 8 -r 10000 -l$HOME/siege.log -m 'Sinatra - Puma'      http://127.0.0.1:3005/
siege -b -c 8 -r 10000 -l$HOME/siege.log -m 'Rack - Passenger'    http://127.0.0.1:3006/
siege -b -c 8 -r 10000 -l$HOME/siege.log -m 'Rack - Unicorn'      http://127.0.0.1:3007/
siege -b -c 8 -r 10000 -l$HOME/siege.log -m 'Rack - Puma'         http://127.0.0.1:3008/
```