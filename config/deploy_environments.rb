namespace :cluster do
  task :setup do
    roles.clear

    set :application, 'website'
    set :repository,  'git@github.com:davidahopp/website.git'
    set :scm, :git
    if exists? :branch
      set :branch, branch
    else
      set :branch, 'master'
    end

    set :deploy_via, :remote_cache
    ssh_options[:forward_agent] = true
    set :keep_releases, 3
    set :use_sudo, false
    set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,'')
    set :deploy_to, '/srv/app/website'


    set :rvm_ruby_string, '1.9.3'
    set :rvm_type, :system
    set :rvm_path, '/usr/local/rvm'
    set :bundle_without,  [:development, :test]

  end
end

namespace :production_app do
  task :setup do
    cluster.setup
    set :rails_env, 'production'
    set :user, 'sitedeploy'
    ssh_options[:keys] = ['~/.ssh/davidahopp_sitedeploy']
    server 'davidahopp.com', :app, :web, :db, :primary => true


  end
end


