# config valid for current version and patch releases of Capistrano
lock '~> 3.17.1'

set :application, 'bbqmaker'
set :repo_url, 'git@github.com:MusicGuns/bbq.git'

set :deploy_to, '/home/deploy/www'

append :linked_files, 'config/database.yml', 'config/secrets.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads'

after 'deploy:restart', 'sidekiq:restart'

set sidekiq_roles: :worker
set sidekiq_default_hooks: true
set sidekiq_env: fetch(:rack_env, fetch(:rails_env, fetch(:stage)))
# single config
set :sidekiq_config_files, ['sidekiq.yml']
# multiple configs
set :sidekiq_config_files, ['sidekiq.yml', 'sidekiq-2.yml'] #  you can also set it per server

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
