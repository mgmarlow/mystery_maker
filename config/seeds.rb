world = YAML.safe_load(File.open("config/world.yml"))

puts "Creating people..."
people = 500.times.map { Person.create_with_random }

puts "Creating locations..."
locations = world["locations"].map { |l| Location.create(name: l) }

def create_date
  Faker::Date.between(from: '2010-04-05', to: '2022-04-12')
    .strftime("%Y%m%d")
end

def create_time
  start_time = (0..2300).step(100).to_a.sample
  end_time = (start_time..2400).step(100).to_a.sample

  [start_time, end_time]
end

puts "Creating events..."
world["events"].each do |data|
  location = Location.find_by(name: data["location"])

  people.sample(100).each do |person|
    start_time, end_time = create_time

    person.events << Event.create(
      name: data["name"],
      location: location,
      date: create_date,
      start_time: start_time,
      end_time: end_time,
    )
  end
end

people_with_events = Person.joins(:events).group('people.id')
important_people = people_with_events.sample(3)

perp = important_people.last
puts "Created perp: #{perp.name}"

witnesses = important_people.take(2)
puts "#{witnesses.length} witnesses: #{witnesses.pluck(:name).join(" and ")}"

