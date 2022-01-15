# MysteryMaker

Randomly-generated mysteries derived from the [SQL City Murder Mystery](https://mystery.knightlab.com/).

> A murder occurred at 20210409 in SQL City. Find the perp!
> (hint: Take a look at crime_scene_reports)

## Installation

```
git clone https://github.com/mgmarlow/mystery_maker.git

cd mystery_maker
bundle install
```

Set up the `mystery.db` Sqlite3 database:

```
bundle exec rake db:reset
```

Test that everything worked as expected:

```
$ sqlite3
$ .open mystery.db
$ select * from 'crime_scene_report' where city='SQL City' and ...;
```

## Playing the game

- Generate a new mystery: `rake db:reset`
- Open the database: `sqlite3 mystery.db`
- Look at the available tables w/ `.tables`:
  ```
  sqlite> .tables
  crime_scene_reports  events_people        people
  drivers_licenses     interviews  
  events               locations
  ```
- Inspect the available columns w/ `.schema`:
  ```
  sqlite> .schema crime_scene_reports
  CREATE TABLE crime_scene_reports (
    date INTEGER,
    kind TEXT,
    description TEXT,
    city TEXT
  );
  ```

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/mgmarlow/mystery_maker).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
