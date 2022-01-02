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
