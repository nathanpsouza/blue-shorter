threads_count = ENV.fetch("RAILS_MAX_THREADS") { 2 }

threads threads_count, threads_count

port        ENV.fetch("PORT") { 3000 }

environment ENV.fetch("RAILS_ENV") { "production" }

workers ENV.fetch("WEB_CONCURRENCY") { 1 }

preload_app!

before_fork do 
    @sidekiq_pid ||= spawn('bundle exec sidekiq -t 1')
end

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

on_restart do
  Sidekiq.redis.shutdown { |conn| conn.close }
end

plugin :tmp_restart