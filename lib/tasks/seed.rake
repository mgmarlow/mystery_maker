namespace :db do
  db_config = YAML::load(File.open("config/database.yml"))

  # TODO: Generate a Faker::Config.random.seed for repro.
  desc "Seed mystery"
  task :seed do
    SQLite3::Database.new(db_config["database"]) do |db|
      persons = (0..500).map { FactoryBot.create(:person) }

      persons.each do |person|
        puts "Seeding #{person.name}"

        insert_license = <<-SQL
          INSERT INTO drivers_license (
            id,
            age,
            height,
            eye_color,
            hair_color,
            gender,
            plate_number,
            car_make,
            car_model
          ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        SQL

        db.execute(insert_license, [
          person.drivers_license.id,
          person.drivers_license.age,
          person.drivers_license.height,
          person.drivers_license.eye_color,
          person.drivers_license.hair_color,
          person.drivers_license.gender,
          person.drivers_license.plate_number,
          person.drivers_license.car_make,
          person.drivers_license.car_model,
        ])

        insert_person = <<-SQL
          INSERT INTO person (
            id,
            name,
            address_number,
            address_street_name,
            ssn,
            license_id
          ) VALUES (?, ?, ?, ?, ?, ?)
        SQL

        db.execute(insert_person, [
          person.id,
          person.name,
          person.address_number,
          person.address_street_name,
          person.ssn,
          person.drivers_license.id
        ])
      end
    end

    puts "Database seeded."
  end
end
