class Income < ActiveRecord::Base
  def self.create_with_random(args={})
    defaults = {
      ssn: Faker::IDNumber.unique.invalid,
      annual_income: Faker::Number.within(range: 40_000..300_000)
    }
    create(defaults.merge(args))
  end
end
