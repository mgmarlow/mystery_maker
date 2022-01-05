module MysteryMaker
  module Clues
    class WitnessAnnabel
      CLUE = "A witness, named Annabel, lives somewhere on \"Franklin Ave\"."
      TRANSCRIPT = "I saw the murder happen, and I recognized the " + \
                   "killer from my gym when I was working out last " + \
                   "week on January the 9th."
      WORKOUT_DATE = 20180109

      attr_reader :perp

      def initialize(perp)
        @perp = perp
      end

      def setup
        create_get_fit_now_check_ins
        create_interview
        generate_noise

        CLUE
      end

      private

      def generate_noise
        # todo
      end

      def create_interview
        Interview.create(person_id: annabel.id, transcript: TRANSCRIPT)
      end

      def create_get_fit_now_check_ins
        GetFitNowCheckIn.create({
          get_fit_now_member: annabel_membership,
          check_in_date: WORKOUT_DATE,
          check_in_time: 1600,
          check_out_time: 1700
        })

        GetFitNowCheckIn.create({
          get_fit_now_member: perp_membership,
          check_in_date: WORKOUT_DATE,
          check_in_time: 1530,
          check_out_time: 1700
        })
      end

      def perp_membership
        existing = GetFitNowMember.find_by(person: perp)
        return existing unless existing.nil?
        GetFitNowMember.create_with_random({ person: perp })
      end

      def annabel_membership
        GetFitNowMember.create_with_random({ person: annabel })
      end

      def annabel
        @annabel ||= begin
          license = DriversLicense.create_with_random({ gender: "female" })
          Person.create_with_random({
            name: "Annabel Miller",
            address_street_name: "Franklin Ave",
            drivers_license: license
          })
        end
      end
    end
  end
end
