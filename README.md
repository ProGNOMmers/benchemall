# Gotta bench'em all!

# WORK IN PROGRESS - STAY OUT!!!

## Disclaimers

1. Benchmarks are benchmarks, nothing more, nothing less
2. Facts written here are taken from the web and/or my experience, so they can be wrong and/or missing. If so, please [let me know](https://github.com/ProGNOMmers/gottabenchemall/issues)
3. I'm not mother tongue in English, so some words/phrases can is incomprensible. If so, please [let me know](https://github.com/ProGNOMmers/gottabenchemall/issues)
4. I love to be silly, please forgive my humor :P

## Description

[Gotta bench'em all!](https://github.com/ProGNOMmers/gottabenchemall) is (at the moment) a collection of some Ruby application servers ([Passenger](https://www.phusionpassenger.com/), [Unicorn](http://unicorn.bogomips.org/), [Puma](http://puma.io/)) benchmarks, but its goal is to provide a replicable benchmarking and benchmarks data collecting and aggregation platform targeting Ruby web applications.

## Preface - [Give me the blood!!!](#benchmarks)

My name is Maurizio De Santis, and I work as web developer in Rome. I use Ruby on Rails at work since the 2.2 version.

As a Ruby developer I'm aware about the variety of Ruby application servers, and the difference they do in the publishing of an high-load web app: you could have to buy another couple of servers just for a bad application server choice.

At the moment there's quite a wide list of Ruby application servers used on production environments: [Mongrel](http://mongrel.rubyforge.org), [Thin](http://code.macournoyer.com/thin/), [Passenger](https://www.phusionpassenger.com/), [Unicorn](http://unicorn.bogomips.org/), [Puma](http://puma.io/)... each of them with its own traits: easy/pain in the ass to install/configure/maintain, stable, reliable (JRuby platform I'm looking at you), multithreading support, fast/slow, resources sparing/hungry, ... 

Over the years, two of them standed out for features tradeoff: Passenger and Unicorn.

## Passenger vs Unicorn: a comparison

### The old days 

<table>
    <tr>
        <th></th>
        <th>Passenger (around version 2 )</th>
        <th>Unicorn (around version 1-2 )</th>
    </tr>
    <tr>
        <td>Installation</td>
        <td>
            <code>gem install passenger && passenger-install-(nginx|apache2)-module</code>, and then you had some options: Passenger was born as a web server module (it didn't even support standalone use), so you had to add the Apache module for using with Apache, or compile it inside Nginx, since Nginx doesn't support modules. Luckily, the Passenger web server module installation script worked like a charm, and I have never got installation problems.
        </td>
        <td><code>gem install unicorn</code></td>
    </tr>
    <tr>
        <td>Configuration</td>
        <td>
            Set up a couple of configuration variables and you were good to go. Just a "little" problem: if you had multiple apps ran by different Ruby interpreters, you could forget to use it: the Ruby executable config scope was at web server level.
        </td>
        <td>Unicorn configuration was not trivial: you had to configure the application server in order to start the web site properly, configure the web server in order to reverse-proxy the application server and to serve the static files, and customize some Unicorn service init scripts found on Google in order to manage the application server processes. Whoa!</td>
    </tr>
    <tr>
        <td>Maintainance</td>
        <td>
            This was IMHO the main Passenger weakness: using it with Nginx (as I did), you had to renounce to install the web server distro package in favour of a compile-and-forget strategy, which can lead to security concerns.
        </td>
        <td><code>gem update unicorn</code> when you didn't have anything to do, even Facebook is boring</td>
    </tr>
    <tr>
        <td>Stability</td>
        <td>
            Stable
        </td>
        <td>
            Stable
        </td>
    </tr>
    <tr>
        <td>Reliability</td>
        <td>
            JRuby no
        </td>
        <td>
            JRuby no
        </td>
    </tr>
    <tr>
        <td>Multithreading</td>
        <td>
            No - I think it spawned child processes (a.k.a. workers)
        </td>
        <td>
            No - spawned child processes (a.k.a. workers)
        </td>
    </tr>
    <tr>
        <td>Resource consumption</td>
        <td>
            If I remember well, even version 2 managed the memory quite well; but I don't know the details (and I don't want to install it :P )
        </td>
        <td>
            And now the dark side of Unicorn: how to occupy 500 MB of RAM with one single application server? start a Rails app with 10 Unicorn workes, et voilà!
        </td>
    </tr>
    <tr>
        <td>Performance</td>
        <td>
            Not slow (which in rubinese meant fast)
        </td>
        <td>
            Not slow (which in rubinese meant fast)
        </td>
    </tr>
</table>

### Nowadays

<table>
    <tr>
        <th></th>
        <th>Passenger ( version 4 )</th>
        <th>Unicorn ( version 4 )</th>
    </tr>
    <tr>
        <td>Installation</td>
        <td>
            As above, plus the standalone option
        </td>
        <td>As above</td>
    </tr>
    <tr>
        <td>Configuration</td>
        <td>
            As above, plus the standalone option and, at last, the Ruby interpreter config option can be scoped inside the Nginx http, server, location or if blocks. Well done!
        </td>
        <td>As above</td>
    </tr>
    <tr>
        <td>Maintainance</td>
        <td>
            As above, plus the standalone option (<code>gem update passenger</code>)
        </td>
        <td>As above</td>
    </tr>
    <tr>
        <td>Stability</td>
        <td>
            Stable (I guess :P )
        </td>
        <td>
            As above (stable)
        </td>
    </tr>
    <tr>
        <td>Reliability</td>
        <td>
            JRuby yes
        </td>
        <td>
            As above (JRuby no)
        </td>
    </tr>
    <tr>
        <td>Multithreading</td>
        <td>
            Yes - it supports both process and thread concurrency models, though it is not possible have them enabled at the same time (unlike f.e. Puma)
        </td>
        <td>
            As above (no)
        </td>
    </tr>
    <tr>
        <td>Resource consumption</td>
        <td>
            Have to benchmark it (TODO: write something about the test results)
        </td>
        <td>
            As above (hungry), but using the REE / Ruby 2.0 <code>GC.copy_on_write_friendly</code> feature things get much better (TODO: write something about the test results)
        </td>
    </tr>
    <tr>
        <td>Performance</td>
        <td>
            TODO: write something about the test results
        </td>
        <td>
            TODO: write something about the test results
        </td>
    </tr>
</table>

## Project name

When I saw the [link about the Passenger 4.1.0 release on Hacker News](https://news.ycombinator.com/item?id=5661874), I thought:

> Horray! This is the moment I waited for years: _gotta bench'em all!!!_

## Benchmarks

Hardware:
CPU: Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz (8 cores)
HD: WesternDigital Caviar Black 7200 RPM
Memory: Corsair DDR3 1333 MHz

Software:
Linux Ubuntu 13.04 64bit
Ruby 2.0.0p0 (CFLAGS="-march=native -O3 -pipe")
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