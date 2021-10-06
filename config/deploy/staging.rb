# customized setup
# ======================

# 'config/credentials/staging.key' 때문에 공통정의 하지 않고 개별환경에서 정의한다.
append :linked_files, *%w[config/database.yml config/master.key config/credentials/staging.key]

# AWS EC2 Ubuntu는 기본으로 아이디는 ubuntu 이다.
set :ssh_host_name, "3.35.236.222"
set :ssh_user, 'ubuntu'
set :ssh_identity_file, "#{ENV['HOME']}/.ssh/pems/atoz-staging-keypair.cer"

# Remote 서버에 대해 배포 환경변수 설정
set :rails_env, "staging"
set :stage, :staging


# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}
server fetch(:ssh_host_name), user: fetch(:ssh_user), port: 22, roles: [:web, :app, :db], primary: true


# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}


set :deploy_to, "/home/#{fetch(:ssh_user)}/#{fetch(:application)}"


# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/user_name/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }

## SSH Remote 설정 (서버 아이디 및 pem Key 경로 설정)
set :ssh_options, {
  keys: [fetch(:ssh_identity_file)],
  forward_agent: true,
  user: fetch(:ssh_user),
}

# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }
