module MysteryMaker
  # TODO: Move these into a method to help generate noise
  MURDER_DATE = 20180115
  NORTHWESTERN_NPCS = 300
  PERP_MEMBER_NUMBER = "48Z55"
  PERP_PLATE_NUMBER = "0H42W2"
  PERP_WORKOUT_DATE = 20180109

  REPORT_DESCRIPTION = <<-DESC
    Security footage shows that there were 2 witnesses.
    The first witness lives at the last house on "Northwestern Dr".
    The second witness, named Annabel, lives somewhere on
    "Franklin Ave".
  DESC
  FIRST_WITNESS_TRANSCRIPT = <<-QUOTE
    I saw the murder happen, and I recognized the
    killer from my gym when I was working out last
    week on January the 9th.
  QUOTE
  SECOND_WITNESS_TRANSCRIPT = <<-QUOTE
    I heard a gunshot and then saw a man run out.
    He had a "Get Fit Now Gym" bag. The membership
    number on the bag started with "48Z". Only gold
    members have those bags. The man got into a car
    with a plate that included "H42W".
  QUOTE
  PERP_TRANSCRIPT = <<-QUOTE
    I was hired by a woman with a lot of money. I don't
    know her name but I know she's around 5'5" (65") or
    5'7" (67"). She has red hair and she drives a Tesla
    Model S. I know that she attended the SQL Symphony
    Concert 3 times in December 2017.
  QUOTE

  # All of the clues needed to solve the mystery.
  # Can be generated randomly, but need to produce
  # deterministic results when seeding.
  # TODO: Add unit tests to ensure the generated path is
  # actually solvable.
  class ScenarioA
    attr_reader :seed

    def initialize
      @seed = Faker::Config.random.seed
    end

    def setup
      create_reports
      create_persons
      create_interviews
      create_get_fit_now_check_ins
      create_facebook_event_check_ins
    end

    def create_reports
      CrimeSceneReport.create({
        description: REPORT_DESCRIPTION,
        type: "murder",
        city: "SQL City",
        date: MURDER_DATE
      })
    end

    def create_persons
      first_witness
      second_witness
      perp
      perp_accomplice
      create_income
    end

    def create_interviews
      Interview.create({
        person_id: first_witness.id,
        transcript: FIRST_WITNESS_TRANSCRIPT
      })
      Interview.create({
        person_id: second_witness.id,
        transcript: SECOND_WITNESS_TRANSCRIPT
      })
      Interview.create({
        person_id: perp.id,
        transcript: PERP_TRANSCRIPT
      })
    end

    def create_get_fit_now_check_ins
      GetFitNowCheckIn.create({
        get_fit_now_member: FactoryBot.build(:get_fit_now_member, person: first_witness),
        check_in_date: PERP_WORKOUT_DATE,
        check_in_time: 1600,
        check_out_time: 1700
      })
      GetFitNowCheckIn.create({
        get_fit_now_member: perp_membership,
        check_in_date: PERP_WORKOUT_DATE,
        check_in_time: 1530,
        check_out_time: 1700
      })
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

    def first_witness
      @first_witness ||= Person.create_with_random(name: "Annabel Miller", address_street_name: "Franklin Ave")
    end

    def second_witness
      @second_witness ||= Person.create_with_random(address_number: NORTHWESTERN_NPCS + 1, address_street_name: "Northwestern Dr")
    end

    # Should this be its own class?
    # TODO: Generate other npcs that have either a plate # or member number like the perp.
    def perp
      @perp ||= begin
        license = DriversLicense.create_with_random(
          plate_number: PERP_PLATE_NUMBER
        )
        Person.create_with_random(drivers_license: license)
      end
    end

    def perp_membership
      GetFitNowMember.create_with_random(person: perp, id: PERP_MEMBER_NUMBER)
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
