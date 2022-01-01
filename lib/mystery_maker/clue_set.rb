module MysteryMaker
  MURDER_DATE = 20180115

  # All of the clues needed to solve the mystery.
  # Can be generated randomly, but need to produce
  # deterministic results when seeding.
  class ClueSet
    def crime_scene_report
      CrimeSceneReport.new({
        desc: "Security footage shows that there were 2 witnesses. The first witness lives at the last house on \"Northwestern Dr\". The second witness, named Annabel, lives somewhere on \"Franklin Ave\".",
        type: "murder",
        city: "SQL City",
        date: MURDER_DATE
      })
    end

    def witness_street_addresses
      ["Northwestern Dr", "Franklin Ave"]
    end
  end
end
