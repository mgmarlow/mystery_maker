module MysteryMaker
  class Helpers
    class << self
      def create_date
        Faker::Date.between(from: "2021-04-05", to: "2021-04-12")
          .strftime("%Y%m%d")
          .to_i
      end

      def witnesses
        solution.event.people
          .filter { |p| p.id != perp.id }
          .take(2)
      end

      def murder_date
        solution.murder_date
      end

      def crime_event
        solution.event
      end

      def perp
        solution.person
      end

      def solution
        Solution.first
      end
    end
  end
end
