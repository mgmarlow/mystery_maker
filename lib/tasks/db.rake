namespace :db do
  db_config = YAML::load(File.open("config/database.yml"))

  desc "Create the database"
  task :create do
    `sqlite3 #{db_config["database"]} < "config/structure.sql"`
    puts "Database created."
  end

  desc "Drop the database"
  task :drop do
    File.delete(db_config["database"]) if File.exists?(db_config["database"])
    puts "Database deleted."
  end

  desc "Seed mystery"
  task :seed do
    scenario = MysteryMaker::ScenarioA.new
    scenario.setup
    puts "Scenario configured."
    puts "Database seeded."
  end

  desc "Reset database with seeded data"
  task reset: [:drop, :create, :seed]
end
