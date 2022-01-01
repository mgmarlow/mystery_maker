namespace :db do
  desc "Create the database"
  task :create do
    MysteryMaker::Repository.new.create_database
    puts "Database created."
  end

  desc "Drop the database"
  task :drop do
    MysteryMaker::Repository.new.drop_database
    puts "Database deleted."
  end

  # TODO: Add unit tests to ensure the generated path is
  # actually solvable.
  # TODO: Generate a Faker::Config.random.seed for repro.
  desc "Seed mystery"
  task :seed do
    repo = MysteryMaker::Repository.new
    clues = MysteryMaker::ClueSet.new

    clues.npcs.each do |person|
      puts "Seeding #{person.name}"
      repo.save_person(person)
    end

    # TODO: Keep track of excepted dates and other clues

    puts "Database seeded."
  end

  desc "Reset database with seeded data"
  task reset: [:drop, :create, :seed]
end
