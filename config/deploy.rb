require 'FileUtils'

dirname = File.join(Rails.root, 'config')
filename = File.join(dirname, 'deploy_settings_local.yml')

unless File.exists?(filename) then
  raise "File deploy_settings_local.yml is missing..."
end

settings = YAML::load_file(filename)

set :application, "jannop"
set :deploy_to, settings["destination_path"]
set :username, settings["server_username"]
set :password, settings["server_password"]

set :scm, "git"
set :scm_username, settings["scm_username"]
set :scm_password, settings["scm_password"]
set :repository, "https://github.com/janno-p/jannop.git"
set :branch, "master"
set :scm_verbose, true
set :use_sudo, false

role :web, settings["web_server"]
role :app, settings["app_server"]
role :db, settings["db_server"], :primary => true

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
