module MysteryMaker
  class ScenarioA
    include Scenario

    crime_scene_report Clues::WitnessAnnabel, Clues::WitnessMorty

    after_setup do
      accomplice = Clues::Accomplice.new
      accomplice_twist = accomplice.setup
      Interview.create(person_id: perp.id, transcript: accomplice_twist)
    end
  end
end
