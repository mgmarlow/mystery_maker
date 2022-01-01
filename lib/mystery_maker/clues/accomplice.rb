module MysteryMaker
  module Clues
    class Accomplice
      def description
        gender_hint = accomplice.drivers_license.gender
        height_hint = accomplice.drivers_license.height
        hair_hint = accomplice.drivers_license.hair_color
        car_hint = "#{accomplice.drivers_license.car_make} #{accomplice.drivers_license.car_model}"

        "I was hired by a #{gender_hint} with a lot of money. " + \
          "I don't know their name, but I know they're around #{height_hint - 2}\" or #{height_hint + 2}\". " + \
          "They have #{hair_hint} hair and they drive a #{car_hint}. " + \
          "I know that they attended the SQL Symphony Concert 3 times in December 2017."
      end

      def generate_noise
        # todo
      end

      def setup_tables
        create_facebook_event_check_ins
        create_income
      end

      def create_income
        Income.create({
          ssn: accomplice.ssn,
          annual_income: 310_000
        })
      end

      def create_facebook_event_check_ins
        FacebookEventCheckIn.create_with_random(
          person: accomplice,
          event_name: "SQL Symphony Concert",
          date: 20171204
        )
        FacebookEventCheckIn.create_with_random(
          person: accomplice,
          event_name: "SQL Symphony Concert",
          date: 20171208
        )
        FacebookEventCheckIn.create_with_random(
          person: accomplice,
          event_name: "SQL Symphony Concert",
          date: 20171218
        )
      end

      def accomplice
        @accomplice ||= Person.create_with_random
      end
    end
  end
end
