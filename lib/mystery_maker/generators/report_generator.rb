class ReportGenerator
  attr_reader :world

  def initialize(world)
    @world = world
  end

  def call
    generate_noise

    CrimeSceneReport.create(
      date: murder_date,
      kind: "murder",
      description: description,
      city: "SQL City"
    )
  end

  private

  def witnesses
    Helpers.witnesses
  end

  def murder_date
    Helpers.murder_date
  end

  def generate_noise
    100.times do
      date = Helpers.create_date
      kinds = if date == murder_date
        world["crimes"].filter { |c| c != "murder" }
      else
        world["crimes"]
      end

      CrimeSceneReport.create(
        date: date,
        kind: kinds.sample,
        description: Faker::Quotes::Shakespeare.hamlet_quote,
        city: world["cities"].sample
      )
    end
  end

  def description
    "Security footage shows there were #{witnesses.length} witnesses. " + \
      first_witness_description + " " + \
      second_witness_description
  end

  def first_witness_description
    witness = witnesses.first

    "The first witness, named #{witness.name.split(" ").first}, " \
      "lives somewhere on #{witness.address_street_name}."
  end

  def second_witness_description
    witness = witnesses.second

    "The second witness is about #{witness.drivers_license.height} tall " \
    "and drives a #{witness.drivers_license.car_make} #{witness.drivers_license.car_model}."
  end
end
