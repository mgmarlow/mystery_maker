namespace :db do
  # TODO: Add unit tests to ensure the generated path is
  # actually solvable.
  # TODO: Generate a Faker::Config.random.seed for repro.
  desc "Seed mystery"
  task :seed do
    repo = MysteryMaker::Repository.new

    persons = (0..500).map { FactoryBot.build(:person) }

    persons.each do |person|
      puts "Seeding #{person.name}"
      repo.save_person(person)
    end

    # TODO: Keep track of excepted dates and other clues

    puts "Database seeded."
  end
end
