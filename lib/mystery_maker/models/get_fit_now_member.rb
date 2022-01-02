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
