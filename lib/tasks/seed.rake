namespace :db do
  db_config = YAML::load(File.open("config/database.yml"))

  desc "Seed mystery"
  task :seed do
    SQLite3::Database.new(db_config["database"]) do |db|
      (0..500).each do
        person = FactoryBot.create(:person)
        puts "Seeding #{person.name}"

        insert_license = <<-SQL
          INSERT INTO drivers_license (
            id
          ) VALUES (?)
        SQL

        db.execute(insert_license, [ person.drivers_license.id ])

        insert_person = <<-SQL
          INSERT INTO person (
            id,
            name,
            address_number,
            address_street_name,
            license_id
          ) VALUES (?, ?, ?, ?, ?)
        SQL

        db.execute(insert_person, [
          person.id,
          person.name,
          person.address_number,
          person.address_street_name,
          person.drivers_license.id
        ])
      end
    end

    puts "Database seeded."
  end
end
