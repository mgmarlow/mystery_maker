world = YAML.safe_load(File.open("config/world.yml"))

def create_random_drivers_license
  DriversLicense.create(
    id: Faker::DrivingLicence.unique.usa_driving_licence,
    age: Faker::Number.number(digits: 2),
    height: Faker::Number.number(digits: 2),
    eye_color: Faker::Color.color_name,
    hair_color: Faker::Color.color_name,
    gender: Faker::Gender.binary_type,
    plate_number: Faker::Alphanumeric.unique.alpha(number: 7),
    car_make: Faker::Vehicle.make,
    car_model: Faker::Vehicle.model
  )
end

puts "Creating people..."
people = 500.times.map do
  Person.create(
    name: Faker::Name.unique.name,
    address_number: Faker::Address.unique.building_number,
    address_street_name: world["streets"].sample,
    ssn: Faker::IDNumber.unique.invalid,
    drivers_license: create_random_drivers_license
  )
end

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

puts "Creating perp..."
perp = people_with_events.sample

puts "Creating witnesses..."
# Find any people that went to the same events as the perp.
witnesses = perp.events
  .flat_map { |event| Event.find(event.id).people }
  .sample(2)

crime_event = perp.events.sample

puts "Creating crime scene reports..."
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
    city: world["cities"].sample
  )
end

# TODO: Move these details down into a separate class (scenario generation).
murder_desc = "Security footage shows there were #{witnesses.length} witnesses. " \
              "The first witness, named #{witnesses.first.name.split(" ").first}, " \
              "lives somewhere on #{witnesses.first.address_street_name}."
murder = CrimeSceneReport.create(
  date: crime_event.date,
  kind: "murder",
  description: murder_desc,
  city: 'SQL City'
)

puts "A murder ocurred at #{murder.date} in #{murder.city}. Find the perp!"
