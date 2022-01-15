# MysteryMaker

Randomly-generated mysteries derived from the [SQL City Murder Mystery](https://mystery.knightlab.com/).

## Installation

```
$ git clone https://github.com/mgmarlow/mystery_maker.git
$ cd ./mystery_maker
$ bundle install
```

## Playing the game

Run `bin/mystery`:

```
$ bin/mystery
**********
A murder occurred at 20210409 in SQL City. Find the perp!
(hint: check crime_scene_reports)
**********
SQLite version 3.36.0 2021-06-18 18:58:49
Enter ".help" for usage hints.
sqlite>
```

On first run, this command will create and seed a database with a working scenario. You can also use the `db` rake commands to re-seed the database with new data:

```
# Reset the database and seed with fresh data
bundle exec rake db:reset
```

## Hints

List all of the available tables with `.tables`:

```
sqlite>.tables
crime_scene_reports  events_people        people
drivers_licenses     interviews           solutions
events               locations
```

Inspect the columns and datatypes of an individual table with `.schema`:

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
