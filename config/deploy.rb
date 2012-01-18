require 'FileUtils'

dirname = File.dirname(__FILE__)
filename = File.join(dirname, 'deploy_settings_local.yml')

unless File.exists?(filename) then
  raise "File deploy_settings_local.yml is missing..."
end

settings = YAML::load_file(filename)

set :application, "jannop"
set :deploy_to, settings["destination_path"]
set :user, settings["server_username"]
set :password, settings["server_password"]
set :use_sudo, false

set :scm, "git"
set :scm_passphrase, settings["scm_passphrase"]
set :repository, "git@github.com:janno-p/jannop.git"
set :branch, "master"
set :deploy_via, :remote_cache

role :web, settings["web_server"]
role :app, settings["app_server"]
role :db, settings["db_server"], :primary => true

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :default_environment, {
  'PATH'         => settings["rvm_path"],
  'RUBY_VERSION' => settings["rvm_ruby_version"],
  'GEM_HOME'     => settings["rvm_gem_home"],
  'GEM_PATH'     => settings["rvm_get_path"],
  'BUNDLE_PATH'  => settings["rvm_bundle_path"],
}

namespace :deploy do
  #after "deploy:setup", "deploy:jannop:setup"
  #after "deploy:symlink", "deploy:jannop:symlink"
  
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  namespace :jannop do
    desc "Create required directories in shared folder"
    task :setup do
      run "cd #{shared_path}; mkdir ckeditor"
      run "cd #{shared_path}; mkdir coins"
    end
    
    desc "Create required symbolic links from shared to common folder"
    task :symlink do
      run "cd #{current_path}/public; rm -rf ckeditor_assets; ln -s #{shared_path}/ckeditor ckeditor_assets"
      run "cd #{current_path}/public; rm -rf coins; ln -s #{shared_path}/coins coins"
    end
  end
end
