module MysteryMaker
  class Helpers
    class << self
      def create_date
        Faker::Date.between(from: "2021-04-05", to: "2021-04-12")
          .strftime("%Y%m%d")
          .to_i
      end
    end
  end
end
