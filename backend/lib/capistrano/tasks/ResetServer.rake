namespace :server do

desc "Reset opcache"
task :opcache_reset do
    on roles(:web) do
        execute :cachetool, "opcache:reset --fcgi=/run/php/php7.0-fpm.sock"
    end
end

end