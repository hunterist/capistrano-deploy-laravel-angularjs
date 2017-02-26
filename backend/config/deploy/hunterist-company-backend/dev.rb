# server-based syntax
server '52.55.238.111', user: 'ubuntu', roles: %w{web}

# role-based syntax
role :web, %w{52.55.238.111}

#set branch
set :branch, :develop

set :ssh_options, {
    keys: ENV['ID_RSA'],
    forward_agent: false,
}
