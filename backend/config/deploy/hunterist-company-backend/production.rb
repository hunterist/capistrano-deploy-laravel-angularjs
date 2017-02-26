# server-based syntax
server '10.0.64.11', user: 'ubuntu', roles: %w{web}
server '10.0.65.12', user: 'ubuntu', roles: %w{web}


# role-based syntax
role :web, %w{10.0.64.11 10.0.65.12}

# set branch
set :branch, :master

if ENV['VIA_BASTION']
    require 'net/ssh/proxy/command'

    bastion_host = ENV['BASTION_PROD_HOST']
    bastion_port = ENV['BASTION_PROD_PORT']
    bastion_user = ENV['BASTION_USER']

    ssh_command = "ssh #{bastion_user}@#{bastion_host} -p #{bastion_port} -W %h:%p"
    set :ssh_options, proxy: Net::SSH::Proxy::Command.new(ssh_command)
end
