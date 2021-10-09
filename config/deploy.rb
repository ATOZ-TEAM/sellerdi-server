require 'dotenv'
current_env = ARGV[0]
Dotenv.load(".env.#{current_env}", '.env')

# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "sellerdi-server"
set :repo_url, "git@github.com:ATOZ-TEAM/sellerdi-server.git"

# Default branch is :master
set :branch, :main # `git rev-parse --abbrev-ref HEAD`.chomp

## 배포 환경변수 설정
set :use_sudo, false
set :deploy_via, :remote_cache

# Default deploy_to directory is /var/www/my_app_name
# ~> config/deploy 의 각 배포 환경별로 정의
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# ~> config/deploy 의 각 배포 환경별로 정의
append :linked_files, *[
  "config/database.yml",

  # key files
  "config/master.key",
  "config/credentials/staging.key",
  "config/credentials/production.key",

  # dotenv files
  ".env",
  ".env.staging",
]

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs, *%w[bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads public/img]


# capistrano-rails config
set :assets_roles, %i[webpack] # Give the webpack role to a single server
set :assets_prefix, 'packs' # Assets are located in /packs/
set :keep_assets, 10 # Automatically remove stale assets
set :assets_manifests, lambda { # Tell Capistrano-Rails how to find the Webpacker manifests
  [release_path.join('public', fetch(:assets_prefix), 'manifest.json*')]
}

# Only attempt migration if db/migrate changed - not related to Webpacker, but a nice thing
set :conditionally_migrate, true


# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        file_uploader = ->(filepath) do
          upload!(filepath, "#{shared_path}/#{filepath}") unless test("[ -f #{shared_path}/#{filepath} ]")
        end
        fetch(:linked_files).each { |file| file_uploader.call(file) }
      end
    end
  end
end
