namespace :angular do

set :angular_dotenv_file, 'config.development.json'

desc 'Angular: Share dotenv file for release'
task :share_env do
  	on roles(:web) do
    	execute :ln, "-s", "#{shared_path}/#{fetch(:angular_dotenv_file)} #{release_path}/#{fetch(:angular_dotenv_file)}"
	end
end

end