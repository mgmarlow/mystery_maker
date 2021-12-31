namespace :db do
  db_config = YAML::load(File.open("config/database.yml"))

  desc "Seed mystery"
  task :seed do
    # TODO:
    # SQLite3::Database.new(db_config["database"]) do |db|
    # end
  end
end
