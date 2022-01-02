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

class Interview < ActiveRecord::Base
  def self.create_with_random(args={})
    defaults = {
      person: Person.create_with_random,
      transcript: Faker::Fantasy::Tolkien.poem
    }
    create(defaults.merge(args))
  end
end

class GetFitNowCheckIn < ActiveRecord::Base
  belongs_to :get_fit_now_member

  def self.create_with_random(args={})
    defaults = {
      get_fit_now_member: GetFitNowMember.create_with_random,
      check_in_date: begin
        check_in = Faker::Date.between_except(from: '2010-01-01', to: '2022-01-01')
        check_in.strftime("%Y%m%d")
      end,
      check_in_time: "todo",
      check_out_time: "todo"
    }
    create(defults.merge(args))
  end
end

class GetFitNowMember < ActiveRecord::Base
  belongs_to :person
  has_many :get_fit_now_check_in

  def self.create_with_random(args={})
    defaults = {
      id: Faker::Alphanumeric.unique.alpha(number: 5),
      membership_start_date: begin
        start = Faker::Date.between(from: "2010-01-01", to: "2022-01-01")
        start.strftime("%Y%m%d")
      end,
      membership_status: %w[bronze silve gold platinum].sample,
      person: Person.create_with_random
    }
    create(defaults.merge(args))
  end
end

class FacebookEventCheckIn < ActiveRecord::Base
  belongs_to :person

  def self.create_with_random(args={})
    defaults = {
      event_id: Faker::Number.number(digits: 7),
      event_name: Faker::Music::Opera.mozart,
      date: begin
        check_in = Faker::Date.between(from: '2010-01-01', to: '2022-01-01')
        check_in.strftime("%Y%m%d")
      end,
      person: Person.create_with_random
    }
    create(defaults.merge(args))
  end
end

class CrimeSceneReport < ActiveRecord::Base
  self.inheritance_column = "klass_type"

  def self.create_with_random(args={})
    FactoryBot.create(:crime_scene_report, *args)
    defaults = {
      date: begin
        check_in = Faker::Date.between_except(from: '2010-01-01', to: '2022-01-01')
        check_in.strftime("%Y%m%d")
      end,
      type: %w[murder robbery theft fraud arson smuggling blackmail].sample,
      description: Faker::Fantasy::Tolkien.unique.poem,
      city: Faker::Address.city
    }
    create(defaults.merge(args))
  end
end

class Income < ActiveRecord::Base
  def self.create_with_random(args={})
    defaults = {
      ssn: Faker::IDNumber.unique.invalid,
      annual_income: Faker::Number.within(range: 40_000..300_000)
    }
    create(defaults.merge(args))
  end
end
