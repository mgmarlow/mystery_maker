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
  person_id TEXT,
  FOREIGN KEY (person_id)
    REFERENCES people (id)
);

CREATE TABLE people (
  id TEXT PRIMARY KEY,
  name TEXT UNIQUE,
  drivers_license_id INTEGER,
  address_number INTEGER UNIQUE,
  address_street_name TEXT
);

CREATE TABLE interviews (
  person_id TEXT,
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
  date INTEGER,
  start_time INTEGER,
  end_time INTEGER,
  FOREIGN KEY (location_id)
    REFERENCES locations (id)
);

CREATE TABLE events_people (
  person_id TEXT,
  event_id INTEGER,
  FOREIGN KEY (person_id)
    REFERENCES people (id),
  FOREIGN KEY (event_id)
    REFERENCES events (id)
);

CREATE TABLE crime_scene_reports (
  date INTEGER,
  kind TEXT,
  description TEXT,
  city TEXT
);

CREATE TABLE scenarios (
  murder_date INTEGER,
  person_id TEXT,
  event_id INTEGER,
  FOREIGN KEY (person_id)
    REFERENCES people (id),
  FOREIGN KEY (event_id)
    REFERENCES events (id)
);
