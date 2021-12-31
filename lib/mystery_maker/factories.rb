class DriversLicense < OpenStruct
end

class Person < OpenStruct
end

FactoryBot.define do
  factory :drivers_license do
    id { Faker::DrivingLicence.unique.usa_driving_licence }
    age { Faker::Number.number(digits: 2) }
    height { Faker::Number.number(digits: 3) }
    eye_color { Faker::Color.color_name }
    hair_color { Faker::Color.color_name }
    gender { Faker::Gender.type }
    plate_number { Faker::Alphanumeric.unique.alpha(number: 7) }
    car_make { Faker::Vehicle.make }
    car_model { Faker::Vehicle.model }
  end
end

FactoryBot.define do
  factory :person do
    id { Faker::Number.unique.number(digits: 10) }
    name { Faker::Name.unique.name }
    address_number { Faker::Address.unique.building_number }
    address_street_name { Faker::Address.street_name }
    drivers_license
  end
end
