  CREATE TABLE drivers_licenses (
    id TEXT PRIMARY KEY,
    age INTEGER,
    height INTEGERL,
    eye_color TEXT,
    hair_color TEXT,
    gender TEXT,
    plate_number TEXT UNIQUE,
    car_make TEXT,
    car_model TEXT,
    person_id INTEGER,
    FOREIGN KEY (person_id)
      REFERENCES people (id)
  );

  CREATE TABLE people (
    id INTEGER PRIMARY KEY,
    name TEXT UNIQUE,
    drivers_license_id INTEGER,
    address_number INTEGER UNIQUE,
    address_street_name TEXT,
    ssn TEXT UNIQUE
  );

  CREATE TABLE interviews (
    person_id INTEGER,
    transcript TEXT,
    FOREIGN KEY (person_id)
      REFERENCES people (id)
  );

  CREATE TABLE get_fit_now_members (
    id TEXT PRIMARY KEY,
    person_id INTEGER,
    membership_start_date INTEGER,
    membership_status TEXT,
    FOREIGN KEY (person_id)
      REFERENCES people (id)
  );

  CREATE TABLE get_fit_now_check_ins (
    get_fit_now_member_id TEXT,
    check_in_date INTEGER,
    check_in_time INTEGER,
    check_out_time INTEGER,
    FOREIGN KEY (get_fit_now_member_id)
      REFERENCES get_fit_now_members (id)
  );

  CREATE TABLE facebook_event_check_ins (
    person_id INTEGER,
    event_id INTEGER,
    event_name TEXT,
    date INTEGER,
    FOREIGN KEY (person_id)
      REFERENCES people (id)
  );

  CREATE TABLE crime_scene_reports (
    date INTEGER,
    type TEXT,
    description TEXT UNIQUE,
    city TEXT
  );

  CREATE TABLE incomes (
    ssn TEXT,
    annual_income INTEGER,
    FOREIGN KEY (ssn)
      REFERENCES people (ssn)
  );
