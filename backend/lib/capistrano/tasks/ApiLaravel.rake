namespace :laravel do

desc "Setup Laravel folder permissions"
  task :permissions do
    on roles(:web) do
      within release_path do
        #execute :chmod, "u+x artisan"
        execute :chmod, "-R 777 storage/app"
        execute :chmod, "-R 777 storage/framework"
        execute :chmod, "-R 777 storage/logs"
     end
   end
 end

desc "Optimize Laravel Class Loader"
  task :optimize do
    on roles(:web) do
      within release_path do
        execute :php, "artisan clear-compiled"
        execute :php, "artisan optimize"
    end
 end
end

desc "Run Laravel clear cache."
task :migrate do
  on roles(:web) do
    within release_path do
        execute :php, "artisan cache:clear"
    end
  end
end

desc "Run Laravel Artisan migrate task."
task :migrate do
  on roles(:web) do
    within release_path do
      execute :php, "artisan migrate", "--force"
    end
  end
end

desc "Restart Laravel queue"
  task :restartqueue do
    on roles(:web) do
      within release_path do
        execute :php, "artisan queue:restart"
    end
 end
end

end