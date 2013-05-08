app_root = "/benchmarks/rails"

directory app_root
environment 'production'
daemonize true
pidfile "#{app_root}/tmp/puma.pid"
stdout_redirect "#{app_root}/log/puma.stdout.log", "#{app_root}/log/puma.stderr.log", true
threads 16, 16
workers 1
bind "unix://#{app_root}/tmp/puma.sock"
