# Deploy Lumen/Laravel source code
# You must install cachetool first to make sure symlink correctly https://github.com/gordalina/cachetool

ask :branch, 'develop'
set :application, proc { fetch(:stage).split(':').reverse[1] }
set :repo_url, proc { "#{ENV['GIT_SOURCE']}/#{fetch(:application)}.git" }
set :deploy_to, proc { "/var/www/#{fetch(:application)}" }
set :scm, :git
set :format, :pretty
set :log_level, :debug
set :pty, true
set :keep_releases, 5

SSHKit.config.command_map[:chmod] = 'sudo chmod'
SSHKit.config.command_map[:cachetool] = 'sudo cachetool'

namespace :deploy do
    before "deploy:symlink:shared", "laravel:share_folder"
    after "laravel:share_folder", "laravel:share_env"
    after "laravel:share_env", "composer:self_update"
    after "composer:self_update", "composer:install"
    after "composer:install", "composer:auto_load"
    after "composer:auto_load", "laravel:permissions"
    after "laravel:permissions", "laravel:restartqueue"
    after :finished, "laravel:migrate"
    after :finished, "server:opcache_reset"
    after :finished, :cleanup
end
