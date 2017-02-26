namespace :composer do

desc "Running composer self-update"
task :self_update do
    on roles(:web) do
        if test "[", "-e", "/usr/local/bin/composer", "]"
            execute :sudo, "composer", "self-update"
        else
            execute :curl, "-sS", "https://getcomposer.org/installer", "|", :php
            execute :sudo, "mv", "composer.phar", "/usr/local/bin/composer"
        end
    end
end

desc "Composer install"
task :install do
    on roles(:web) do
        within release_path do
            execute :composer, "install"
        end
    end
end

desc "Composer dump-autoload"
task :auto_load do
    on roles(:web) do
        within release_path do
            execute :composer, "dump-autoload"
        end
    end
end
end
