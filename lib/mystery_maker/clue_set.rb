module MysteryMaker
  MURDER_DATE = 20180115
  NORTHWESTERN_NPCS = 300
  REPORT_DESCRIPTION = "Security footage shows that there were 2 witnesses. The first witness lives at the last house on \"Northwestern Dr\". The second witness, named Annabel, lives somewhere on \"Franklin Ave\"."
  FIRST_WITNESS_TRANSCRIPT = "I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th."
  SECOND_WITNESS_TRANSCRIPT = "I heard a gunshot and then saw a man run out. He had a \"Get Fit Now Gym\" bag. The membership number on the bag started with \"48Z\". Only gold members have those bags. The man got into a car with a plate that included \"H42W\"."

  # All of the clues needed to solve the mystery.
  # Can be generated randomly, but need to produce
  # deterministic results when seeding.
  class ClueSet
    def crime_scene_report
      CrimeSceneReport.new({
        desc: REPORT_DESCRIPTION,
        type: "murder",
        city: "SQL City",
        date: MURDER_DATE
      })
    end

    # TODO: Separate clues into classes so they can be composed
    # into different scenarios.
    def witness_street_addresses
      ["Northwestern Dr", "Franklin Ave"]
    end

    # Assuming extra noise is generated separately
    def npcs
      min = 0
      max = NORTHWESTERN_NPCS

      nearby_npcs = (min..max).map do |i|
        FactoryBot.build(
          :person,
          address_street_name: witness_street_addresses.sample,
          address_number: i
        )
      end

      important_npcs = [
        first_witness,
        second_witness
      ]

      (important_npcs + nearby_npcs).shuffle
    end

    def interviews
      [
        Interview.new({
          person_id: first_witness.id,
          transcript: FIRST_WITNESS_TRANSCRIPT
        }),
        Interview.new({
          person_id: second_witness.id,
          transcript: SECOND_WITNESS_TRANSCRIPT
        })
      ]
    end

    def first_witness
      @first_witness ||= FactoryBot.build(:person, name: "Annabel Miller", address_street_name: "Franklin Ave")
    end

    def second_witness
      @second_witness ||= FactoryBot.build(:person, address_number: NORTHWESTERN_NPCS + 1, address_street_name: "Northwestern Dr")
    end
  end
end
