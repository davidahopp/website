require "rvm/capistrano"
require "bundler/capistrano"

namespace :production do
  task :setup do
    production_app.setup
    setup_app
  end

  task :check do
    production_app.setup
    check_app
  end

  task :deploy do
    production_app.setup
    deploy_app
  end

end


task :deploy_app do
  deploy.default
end

task :setup_app do
  deploy.setup
end

task :check_app do
  deploy.check
end

namespace :deploy do
  #task :start do ; end
  #task :stop do ; end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :assets do
  task :precompile do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
  end
  task :clean do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake assets:clean"
  end
  task :cleanup do
    assets.clean
    assets.precompile
  end
end

namespace :db do
  task :setup do
    run "ln -sf #{shared_path}/database.yml #{current_path}/config/"
  end

  task :migrate do
    run "cd #{current_path} && bundle exec rake RAILS_ENV=#{rails_env} db:migrate"
  end

  task :seed do
    run "cd #{current_path} && bundle exec rake RAILS_ENV=#{rails_env} db:seed"
  end

  task :rollback do
    if previous_release
      run "cd #{current_path} && bundle exec rake RAILS_ENV=#{rails_env} db:migrate VERSION=`cat #{previous_release}/migration_version.txt`"
    end
  end

  task :set_version do
    run "cd #{release_path} && bundle exec rake RAILS_ENV=#{rails_env} db:current_version > migration_version.txt"
  end

  task :migrate_to_zero do
    # should dump all the tables
    run "cd #{current_path} && bundle exec rake RAILS_ENV=#{rails_env} db:migrate VERSION=0"
  end
end

after "deploy:update", "db:setup"
after "db:setup", "db:migrate"
after "db:migrate", "db:seed"
after "db:migrate", "db:set_version"
after "deploy:restart", "deploy:cleanup"
before "deploy:restart", "assets:cleanup"

before "deploy:rollback", "db:rollback"
after "deploy:rollback:revision", "bundle:install"
after "deploy:update_code", "bundle:install"