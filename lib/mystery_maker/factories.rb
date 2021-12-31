class DriversLicense < OpenStruct
end

class Person < OpenStruct
end

class Interview < OpenStruct
end

class GetFitNowCheckin < OpenStruct
end

class GetFitNowMember < OpenStruct
end

class FacebookEventCheckin < OpenStruct
end

class CrimeSceneReport < OpenStruct
end

class Income < OpenStruct
end

MURDER_DATE = '2018-01-24' # todo

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
    id { Faker::Alphanumeric.unique.alpha(number: 4) }
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
    # Exclude certain dates that will be used in mysteries
    check_in_date do
      check_in = Faker::Date.between_except(
        from: '2010-01-01',
        to: '2022-01-01',
        excepted: MURDER_DATE
      )
      check_in.strftime("%Y%m%d")
    end
    check_in_time { "todo" }
    check_out_time { "todo" }
  end
end

FactoryBot.define do
  factory :crime_scene_report do
    date do
      check_in = Faker::Date.between_except(
        from: '2010-01-01',
        to: '2022-01-01',
        excepted: MURDER_DATE
      )
      check_in.strftime("%Y%m%d")
    end
    type { %w[murder].sample } # todo
    description { Faker::Fantasy::Tolkien.unique.poem }
    city { Faker::Address.city }
  end
end

FactoryBot.define do
  factory :facebook_event_checkin do
  end
end

FactoryBot.define do
  factory :income do
  end
end
