# MysteryMaker

Randomly-generated mysteries derived from the [SQL City Murder Mystery](https://mystery.knightlab.com/).

Solve the case:

> A crime has taken place and the detective needs your help. The
> detective gave you the crime scene report, but you somehow lost it.
> You vaguely remember that the crime was a ​murder​ that occurred sometime
> on ​Jan.15, 2018​ and that it took place in ​SQL City​. Start by retrieving
> the corresponding crime scene report from the police department’s database.

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
$ select * from 'crime_scene_report' where city='SQL City' and date=20180115 and type='murder';
```

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/mgmarlow/mystery_maker).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
