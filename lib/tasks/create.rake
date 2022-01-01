namespace :db do
  desc "Create the database"
  task :create do
    MysteryMaker::Repository.new.create_database
    puts "Database created."
  end
end
