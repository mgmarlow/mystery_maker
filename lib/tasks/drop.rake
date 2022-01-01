namespace :db do
  desc "Drop the database"
  task :drop do
    MysteryMaker::Repository.new.drop_database
    puts "Database deleted."
  end
end
