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
