namespace :db do
  db_config = YAML::load(File.open("config/database.yml"))

  desc "Create the database"
  task :create do
    raise "Error: database already created" if File.exists?(db_config["database"])

    SQLite3::Database.new(db_config["database"]) do |db|
      db.execute <<-SQL
        CREATE TABLE drivers_license (
          id INTEGER PRIMARY KEY,
          age INTEGER,
          height INTEGERL,
          eye_color TEXT,
          hair_color TEXT,
          gender TEXT,
          plate_number TEXT UNIQUE,
          car_make TEXT,
          car_model TEXT
        );
      SQL

      db.execute <<-SQL
        CREATE TABLE person (
          id INTEGER PRIMARY KEY,
          name TEXT UNIQUE,
          license_id INTEGER,
          address_number INTEGER UNIQUE,
          address_street_name TEXT,
          FOREIGN KEY (license_id)
            REFERENCES drivers_license (id)
        );
      SQL
    end
    puts "Database created"
  end
end
