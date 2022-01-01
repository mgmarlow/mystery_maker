module MysteryMaker
  class Repository
    attr_reader :db, :db_config

    def initialize
      @db_config = YAML::load(File.open("config/database.yml"))
      @db = SQLite3::Database.new(db_config["database"])
    end

    def create_database
      db.execute_batch <<-SQL
        CREATE TABLE drivers_license (
          id TEXT PRIMARY KEY,
          age INTEGER,
          height INTEGERL,
          eye_color TEXT,
          hair_color TEXT,
          gender TEXT,
          plate_number TEXT UNIQUE,
          car_make TEXT,
          car_model TEXT
        );

        CREATE TABLE person (
          id INTEGER PRIMARY KEY,
          name TEXT UNIQUE,
          license_id INTEGER,
          address_number INTEGER UNIQUE,
          address_street_name TEXT,
          ssn TEXT UNIQUE,
          FOREIGN KEY (license_id)
            REFERENCES drivers_license (id)
        );

        CREATE TABLE interview (
          person_id INTEGER,
          transcript TEXT,
          FOREIGN KEY (person_id)
            REFERENCES person (id)
        );

        CREATE TABLE get_fit_now_member (
          id TEXT PRIMARY KEY,
          person_id INTEGER,
          membership_start_date INTEGER,
          membership_status TEXT,
          FOREIGN KEY (person_id)
            REFERENCES person (id)
        );

        CREATE TABLE get_fit_now_checkin (
          membership_id TEXT,
          check_in_date INTEGER,
          check_in_time INTEGER,
          check_out_time INTEGER,
          FOREIGN KEY (membership_id)
            REFERENCES get_fit_now_member (id)
        );

        CREATE TABLE facebook_event_checkin (
          person_id INTEGER,
          event_id INTEGER,
          event_name TEXT,
          date INTEGER,
          FOREIGN KEY (person_id)
            REFERENCES person (id)
        );

        CREATE TABLE crime_scene_report (
          date INTEGER,
          type TEXT,
          description TEXT UNIQUE,
          city TEXT
        );

        CREATE TABLE income (
          ssn INTEGER,
          annual_income INTEGER,
          FOREIGN KEY (ssn)
            REFERENCES person (ssn)
        );
      SQL
    end

    def drop_database
      File.delete(db_config["database"]) if File.exists?(db_config["database"])
    end

    def save_person(person)
      license_query = <<-SQL
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

      db.execute(license_query, [
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

      person_query = <<-SQL
        INSERT INTO person (
          id,
          name,
          address_number,
          address_street_name,
          ssn,
          license_id
        ) VALUES (?, ?, ?, ?, ?, ?)
      SQL

      db.execute(person_query, [
        person.id,
        person.name,
        person.address_number,
        person.address_street_name,
        person.ssn,
        person.drivers_license.id
      ])
    end

    def save_crime_scene_report(report)
      query = <<-SQL
        INSERT INTO crime_scene_report (
          date,
          type,
          description,
          city
        ) VALUES (?, ?, ?, ?)
      SQL

      db.execute(person_query, [
        report.date,
        report.type,
        report.description,
        report.city
      ])
    end
  end
end
