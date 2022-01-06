world = YAML.safe_load(File.open("config/world.yml"))

puts "Creating people..."
people = 500.times.map { Person.create_with_random }

puts "Creating locations..."
locations = world["locations"].map { |l| Location.create(name: l) }

def create_date
  Faker::Date.between(from: '2021-04-05', to: '2021-04-12')
    .strftime("%Y%m%d")
    .to_i
end

# Each event occurred 5 times during the week at random 1-hr intervals.
def create_time_windows
  (0..2300).step(100).to_a.sample(5).map do |start_time|
    [create_date, start_time, start_time + 100]
  end
end

puts "Creating events..."
world["events"].each do |data|
  location = Location.find_by(name: data["location"])

  events = create_time_windows.map do |window|
    date, start_time, end_time = window

    Event.create(
      name: data["name"],
      location: location,
      date: date,
      start_time: start_time,
      end_time: end_time,
    )
  end

  # Add 15 people to each event
  events.each do |event|
    people.sample(15).each do |person|
      person.events << event
    end
  end
end

people_with_events = Person.joins(:events).group('people.id')

perp = people_with_events.sample
puts "Created perp: #{perp.name}."

# Find any people that went to the same events as the perp.
witnesses = perp.events.flat_map do |event|
  Event.find(event.id).people
end
puts "#{witnesses.length} witnesses: #{witnesses.pluck(:name).join(", ")}."

crime_event = perp.events.sample
puts "Creating erroneous crime scene reports..."
100.times do
  date = create_date

  kinds = if date == crime_event.date
    world["crimes"].filter { |c| c != "murder" }
  else
    world["crimes"]
  end

  CrimeSceneReport.create(
    date: date,
    kind: kinds.sample,
    description: Faker::Quotes::Shakespeare.hamlet_quote,
    location: locations.sample.name
  )
end

puts "Creating the real crime scene report..."
murder = CrimeSceneReport.create(
  date: crime_event.date,
  kind: "murder",
  # TODO: Clue
  description: "A crime occurred at #{crime_event.name}.",
  location: crime_event.location.name
)

puts "A murder ocurred at #{murder.date} at #{murder.location}. Find the perp!"
