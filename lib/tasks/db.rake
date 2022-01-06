namespace :db do
  db_config = YAML.safe_load(File.open("config/database.yml"))

  desc "Create the database"
  task :create do
    `sqlite3 #{db_config["database"]} < "config/structure.sql"`
    puts "Database created."
  end

  desc "Drop the database"
  task :drop do
    File.delete(db_config["database"]) if File.exist?(db_config["database"])
    puts "Database deleted."
  end

  desc "Seed mystery"
  task :seed do
    load("config/seeds.rb")
  end

  desc "Reset database with seeded data"
  task reset: [:drop, :create, :seed]
end
