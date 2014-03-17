# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'rand'
set :repo_url, 'git@github.com:RoryDH/rand.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/root/www/rand'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :gulp_tasks, 'compile'
set :bundle_dir, "/usr/local/rvm/gems/ruby-2.1.0"
set :rvm1_ruby_version, "2.1.0"

namespace :deploy do
  after 'npm:install', 'gulp'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      execute "sudo service nginx restart"
    end
  end

  after :publishing, :restart

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end

  desc 'Runs rake db:migrate if migrations are set'
  task :rand_migrate do
    on roles(:web) do
      within release_path do
        execute :rake, "db:migrate"
      end
    end
  end

  after :updated, :rand_migrate

end
