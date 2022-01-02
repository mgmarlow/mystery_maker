class Person < ActiveRecord::Base
  has_one :drivers_license

  def self.create_with_random(args={})
    defaults = {
      id: Faker::Number.unique.number(digits: 10),
      name: Faker::Name.unique.name,
      address_number: Faker::Address.unique.building_number,
      address_street_name: Faker::Address.street_name,
      ssn: Faker::IDNumber.unique.invalid,
      drivers_license: DriversLicense.create_with_random
    }
    create(defaults.merge(args))
  end
end
