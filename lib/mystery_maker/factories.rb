class DriversLicense < OpenStruct
end

class Person < OpenStruct
end


# Called via FactoryBot.build(:person), etc.

FactoryBot.define do
  factory :drivers_license do
  end
end

FactoryBot.define do
  factory :person do
    name { Faker::Name.unique.name }
  end
end

