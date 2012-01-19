# RVM bootstrap
set :default_environment, {
  'PATH' => '/usr/local/rvm/gems/ruby-1.9.3-p0/bin:/usr/local/rvm/gems/ruby-1.9.3-p0@global/bin:/usr/local/rvm/rubies/ruby-1.9.3-p0/bin:/usr/local/rvm/bin:$PATH',
  'RUBY_VERSION' => 'ruby 1.9.3',
  'GEM_HOME' => '/usr/local/rvm/gems/ruby-1.9.3-p0',
  'GEM_PATH' => '/usr/local/rvm/gems/ruby-1.9.3-p0:/usr/local/rvm/gems/ruby-1.9.3-p0@global',
}

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
set :normalize_asset_timestamps, false

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
  
  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  end
end
