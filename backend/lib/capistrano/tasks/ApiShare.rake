namespace :laravel do

desc "Share storage folder for release."
task :share_folder do

	set :laravel_dotenv_file, '.env'
	set :laravel_linked_dirs, [
        'storage',
    ]

	on roles(:web) do
		fetch(:laravel_linked_dirs).each do |file|
			#execute :mkdir, "-p", "#{release_path.join(fetch(:api_folder))}/#{file}"
			execute :ln, "-s","#{shared_path}/#{file} #{release_path}/#{file}-tmp"
			#execute :rm, "-R", "#{release_path.join(fetch(:api_folder))}/#{file}"
			execute :mv, "-Tf", "#{release_path}/#{file}-tmp #{release_path}/#{file}"
		end
	end
end

desc "Share dotenv file for release."
task :share_env do
  	on roles(:web) do
    	execute :ln, "-s", "#{shared_path}/#{fetch(:laravel_dotenv_file)} #{release_path}/#{fetch(:laravel_dotenv_file)}"
	end
end

end
