# RVM bootstrap
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.3-p0'

# Bundler bootstrap
require 'bundler/capistrano'

# Load sensitive info from settings file
settings = YAML::load_file(File.join(File.dirname(__FILE__), 'deploy.yml'))

# Main details
set :application, settings["application"]
role :web, settings["application"]
role :app, settings["application"]
role :db, settings["application"], :primary => true

# Server details
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_to, settings["deploy_to"]
set :deploy_via, :remote_cache
set :user, settings["user"]
set :use_sudo, false

# Repository details
set :scm, :git
set :repository, "git@github.com:janno-p/jannop.git"
set :branch, "master"
set :git_enable_submodules, 1

# Capistrano tasks
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
