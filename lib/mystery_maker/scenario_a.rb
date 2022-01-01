module MysteryMaker
  # TODO: Move these into a method to help generate noise
  MURDER_DATE = 20180115

  PERP_TRANSCRIPT = <<-QUOTE
    I was hired by a woman with a lot of money. I don't
    know her name but I know she's around 5'5" (65") or
    5'7" (67"). She has red hair and she drives a Tesla
    Model S. I know that she attended the SQL Symphony
    Concert 3 times in December 2017.
  QUOTE

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
      create_perp_transcript
    end

    def create_crime_scene_report(desc)
      CrimeSceneReport.create({
        description: desc,
        type: "murder",
        city: "SQL City",
        date: MURDER_DATE
      })
    end

    # TODO: Move to clue
    def create_perp_transcript
      Interview.create(person_id: perp.id, transcript: PERP_TRANSCRIPT)
    end

    def create_facebook_event_check_ins
      FacebookEventCheckIn.create_with_random(
        person: perp_accomplice,
        event_name: "SQL Symphony Concert",
        date: 20171204
      )
      FacebookEventCheckIn.create_with_random(
        person: perp_accomplice,
        event_name: "SQL Symphony Concert",
        date: 20171208
      )
      FacebookEventCheckIn.create_with_random(
        person: perp_accomplice,
        event_name: "SQL Symphony Concert",
        date: 20171218
      )
    end

    def create_income
      Income.create({
        ssn: perp_accomplice.ssn,
        annual_income: 310_000
      })
    end

    private

    def perp
      @perp ||= Person.create_with_random
    end

    def perp_accomplice
      @perp_accomplice ||= begin
        license = DriversLicense.create_with_random(
          car_model: "Model S",
          car_make: "Tesla",
          height: 66,
          hair_color: "red",
          gender: "female"
        )
        FactoryBot.create(:person, drivers_license: license)
      end
    end
  end
end
