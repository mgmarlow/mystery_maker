class ReportGenerator
  attr_reader :witnesses, :murder_date

  def initialize(witnesses, murder_date)
    @witnesses = witnesses
    @murder_date = murder_date
  end

  def call
    CrimeSceneReport.create(
      date: murder_date,
      kind: "murder",
      description: description,
      city: "SQL City"
    )
  end

  private

  def description
    "Security footage shows there were #{witnesses.length} witnesses. " + \
      first_witness_description
  end

  def first_witness_description
    "The first witness, named #{witnesses.first.name.split(" ").first}, " \
      "lives somewhere on #{witnesses.first.address_street_name}."
  end
end
