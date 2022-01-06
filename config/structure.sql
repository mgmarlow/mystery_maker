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

CREATE TABLE locations (
  id INTEGER PRIMARY KEY,
  name TEXT
);

CREATE TABLE events (
  id INTEGER PRIMARY KEY,
  location_id INTEGER,
  name TEXT,
  start_time INTEGER,
  end_time INTEGER,
  FOREIGN KEY (location_id)
    REFERENCES locations (id)
);

CREATE TABLE people_events (
  person_id INTEGER,
  event_id INTEGER,
  FOREIGN KEY (person_id)
    REFERENCES people (id),
  FOREIGN KEY (event_id)
    REFERENCES events (id)
);

CREATE TABLE crime_scene_reports (
  date INTEGER,
  kind TEXT,
  description TEXT UNIQUE,
  city TEXT
);
