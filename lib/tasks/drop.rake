namespace :db do
  db_config = YAML::load(File.open("config/database.yml"))

  desc "Drop the database"
  task :drop do
    File.delete(db_config["database"]) if File.exists?(db_config["database"])
    puts "Database deleted."
  end
end
