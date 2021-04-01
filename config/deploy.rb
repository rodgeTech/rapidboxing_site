# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

set :application, "rapidboxing"
set :repo_url, "git@gitlab.com:mybelizecommerce/rapid-boxing-website.git"

set :deploy_to, "/home/deploy/#{fetch :application}"

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'

# Only keep the last 5 releases to save disk space
set :keep_releases, 5
