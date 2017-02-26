namespace :angular do

desc 'Run Gulp'
task :gulp do
  	on roles(:web) do
  		within release_path do
  			execute :npm, "install"
	    	execute :gulp, "build"
    	end
	end
end

end