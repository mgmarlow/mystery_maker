module MysteryMaker
  MURDER_DATE = 20180115

  class ScenarioA
    attr_reader :seed

    def initialize
      @seed = Faker::Config.random.seed
    end

    def setup
      report_description = "Security footage shows that there were 2 witnesses."

      clue_a = Clues::Annabel.new(perp)
      clue_a.setup_tables
      report_description += " " + clue_a.description

      clue_b = Clues::Morty.new(perp)
      clue_b.setup_tables
      report_description += " " + clue_b.description

      create_crime_scene_report(report_description)

      clue_c = Clues::Accomplice.new
      clue_c.setup_tables
      create_perp_transcript(clue_c.description)
    end

    private

    def create_crime_scene_report(desc)
      CrimeSceneReport.create({
        description: desc,
        type: "murder",
        city: "SQL City",
        date: MURDER_DATE
      })
    end

    def create_perp_transcript(desc)
      Interview.create(person_id: perp.id, transcript: desc)
    end

    def perp
      @perp ||= Person.create_with_random
    end
  end
end
