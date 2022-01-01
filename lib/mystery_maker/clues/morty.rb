module MysteryMaker
  module Clues
    class Morty
      DESCRIPTION = "A witness lives at the last house on \"Northwestern Dr\"."
      ADDRESS_NUMBER = 478

      attr_reader :perp

      def initialize(perp)
        @perp = perp
      end

      def description
        DESCRIPTION
      end

      def setup_tables
        create_interview
        generate_noise
      end

      def generate_noise
        # todo
      end

      def create_interview
        Interview.create(person_id: morty.id, transcript: transcript)
      end

      def transcript
        plate_hint = perp.drivers_license.plate_number[1..4]
        gender_hint = perp.drivers_license.gender
        member_hint = perp_membership.id[0..2]
        status_hint = perp_membership.membership_status

        "I heard a gunshot and then saw a #{gender_hint} run out. " + \
          "He had a \"Get Fit Now Gym\" bag. The membership " + \
          "number on the bag started with \"#{member_hint}\". Only #{status_hint} " + \
          "members have those bags. The #{gender_hint} got into a car " + \
          "with a plate that included \"#{plate_hint}\"."
      end

      def perp_membership
        existing = GetFitNowMember.find_by(person: perp)
        return existing unless existing.nil?
        GetFitNowMember.create_with_random(person: perp)
      end

      def morty
        @morty ||= Person.create_with_random(
          name: "Morty Shapiro",
          address_number: ADDRESS_NUMBER,
          address_street_name: "Northwestern Dr"
        )
      end
    end
  end
end
