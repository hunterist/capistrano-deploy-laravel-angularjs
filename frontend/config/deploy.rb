# You must have 3 config types for setting before using gulp build
# 1. config.development.json for development servers
# 2. config.staging.json for staging servers
# 3. config.production.json for production servers

ask :branch, 'master'
set :environment, proc { fetch(:stage).split(':').reverse[0] }
set :application, proc { fetch(:stage).split(':').reverse[1] }
set :repo_url, proc { "#{ENV['GIT_SOURCE']}/#{fetch(:application)}.git" }
set :deploy_to, proc { "/var/www/#{fetch(:application)}" }
set :scm, :git
set :format, :pretty
set :log_level, :debug
set :pty, true
set :keep_releases, 5

set :theme_path, Pathname.new('public')
set :local_app_path, Pathname.new("#{ENV['FRONTEND_PATH']}/#{fetch(:application)}") 
set :local_theme_path, fetch(:local_app_path).join(fetch(:theme_path))


namespace :deploy do
    task :compile_assets do
        run_locally do
            within fetch(:local_app_path) do
                if fetch(:environment) == 'staging'
                    execute :cp, "-rf", "config.staging.json", "config.development.json"
                elsif fetch(:environment) == 'production'
                    execute :cp, "-rf", "config.production.json", "config.development.json"
                end
                execute :npm, :install
                execute :gulp, :build
            end
        end
    end

    task :copy_assets do
        invoke 'deploy:compile_assets'

        on roles(:web) do
            upload! fetch(:local_theme_path).to_s, release_path.join(fetch(:theme_path)), recursive: true
        end
    end
end

before "deploy:updated", "deploy:copy_assets"
before "deploy:updated", "angular:share_env"

