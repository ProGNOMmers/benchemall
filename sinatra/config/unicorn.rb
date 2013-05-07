ENV['RACK_ENV'] = 'production'
app_root = "/benchmarks/sinatra"

worker_processes 8
working_directory app_root
listen "#{app_root}/tmp/unicorn.sock", :backlog => 64
pid "#{app_root}/tmp/unicorn.pid"
stderr_path "#{app_root}/log/unicorn.stderr.log"
stdout_path "#{app_root}/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

check_client_connection false