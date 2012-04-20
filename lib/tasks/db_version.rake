namespace :db do
  desc 'Print the current database migration version number'
  task :current_version => :environment do
    puts ActiveRecord::Migrator.current_version
  end
end