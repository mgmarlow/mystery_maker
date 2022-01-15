class PersonGenerator
  attr_reader :world

  def initialize(world)
    @world = world
  end

  def call
    500.times.map do
      Person.create(
        id: Faker::IDNumber.unique.invalid,
        name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
        address_number: Faker::Address.unique.building_number,
        address_street_name: world["streets"].sample,
        drivers_license: create_random_drivers_license
      )
    rescue ActiveRecord::RecordNotUnique
      # Just skip over clashing names and exclude the nil records
    end.compact
  end

  private

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
end
