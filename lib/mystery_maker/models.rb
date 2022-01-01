class DriversLicense < ActiveRecord::Base
  def self.create_with_random(*args)
    FactoryBot.create(:drivers_license, *args)
  end
end

class Person < ActiveRecord::Base
  has_one :drivers_license

  def self.create_with_random(*args)
    FactoryBot.create(:person, *args)
  end
end

class Interview < ActiveRecord::Base
  def self.create_with_random(*args)
    FactoryBot.create(:interview, *args)
  end
end

class GetFitNowCheckIn < ActiveRecord::Base
  belongs_to :get_fit_now_member

  def self.create_with_random(*args)
    FactoryBot.create(:get_fit_now_check_in, *args)
  end
end

class GetFitNowMember < ActiveRecord::Base
  belongs_to :person
  has_many :get_fit_now_check_in

  def self.create_with_random(*args)
    FactoryBot.create(:get_fit_now_member, *args)
  end
end

class FacebookEventCheckIn < ActiveRecord::Base
  belongs_to :person

  def self.create_with_random(*args)
    FactoryBot.create(:facebook_event_check_in, *args)
  end
end

class CrimeSceneReport < ActiveRecord::Base
  self.inheritance_column = "klass_type"

  def self.create_with_random(*args)
    FactoryBot.create(:crime_scene_report, *args)
  end
end

class Income < ActiveRecord::Base
  def self.create_with_random(*args)
    FactoryBot.create(:income, *args)
  end
end

FactoryBot.define do
  factory :drivers_license do
    id { Faker::DrivingLicence.unique.usa_driving_licence }
    age { Faker::Number.number(digits: 2) }
    height { Faker::Number.number(digits: 2) }
    eye_color { Faker::Color.color_name }
    hair_color { Faker::Color.color_name }
    gender { Faker::Gender.binary_type }
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
    ssn { Faker::IDNumber.unique.invalid }
    drivers_license
  end
end

FactoryBot.define do
  factory :interview do
    person
    transcript { Faker::Fantasy::Tolkien.poem }
  end
end

FactoryBot.define do
  factory :get_fit_now_member do
    id { Faker::Alphanumeric.unique.alpha(number: 5) }
    membership_start_date do
      start = Faker::Date.between(from: "2010-01-01", to: "2022-01-01")
      start.strftime("%Y%m%d")
    end
    membership_status { %w[bronze silve gold platinum].sample }
    person
  end
end

FactoryBot.define do
  factory :get_fit_now_checkin do
    membership { association :get_fit_now_member }
    check_in_date do
      check_in = Faker::Date.between_except(from: '2010-01-01', to: '2022-01-01')
      check_in.strftime("%Y%m%d")
    end
    check_in_time { "todo" }
    check_out_time { "todo" }
  end
end

FactoryBot.define do
  factory :crime_scene_report do
    date do
      check_in = Faker::Date.between_except(from: '2010-01-01', to: '2022-01-01')
      check_in.strftime("%Y%m%d")
    end
    type { %w[murder robbery theft fraud arson smuggling blackmail].sample }
    description { Faker::Fantasy::Tolkien.unique.poem }
    city { Faker::Address.city }
  end
end

FactoryBot.define do
  factory :facebook_event_check_in do
    event_id { Faker::Number.number(digits: 7) }
    event_name { Faker::Music::Opera.mozart }
    date do
      check_in = Faker::Date.between_except(from: '2010-01-01', to: '2022-01-01')
      check_in.strftime("%Y%m%d")
    end
    person
  end
end

FactoryBot.define do
  factory :income do
    ssn { Faker::IDNumber.unique.invalid }
    annual_income { Faker::Number.within(range: 40_000..300_000) }
  end
end
