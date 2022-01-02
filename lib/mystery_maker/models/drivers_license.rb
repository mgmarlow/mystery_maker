class DriversLicense < ActiveRecord::Base
  def self.create_with_random(args={})
    defaults = {
      id: Faker::DrivingLicence.unique.usa_driving_licence,
      age: Faker::Number.number(digits: 2),
      height: Faker::Number.number(digits: 2),
      eye_color: Faker::Color.color_name,
      hair_color: Faker::Color.color_name,
      gender: Faker::Gender.binary_type,
      plate_number: Faker::Alphanumeric.unique.alpha(number: 7),
      car_make: Faker::Vehicle.make,
      car_model: Faker::Vehicle.model
    }
    create(defaults.merge(args))
  end
end
