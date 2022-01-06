world = YAML.safe_load(File.open("config/world.yml"))

puts "Creating people..."
people = 500.times.map { Person.create_with_random }

puts "Creating locations..."
locations = world["locations"].map { |l| Location.create(name: l) }

def create_date
  Faker::Date.between(from: '2021-04-05', to: '2021-04-12')
    .strftime("%Y%m%d")
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
important_people = people_with_events.sample(3)

perp = important_people.last
puts "Created perp: #{perp.name}"

# Find any people that went to the same event.
witnesses = perp.events.flat_map do |event|
  Event.find(event.id).people
end
puts "#{witnesses.length} witnesses: #{witnesses.pluck(:name).join(" and ")}"

