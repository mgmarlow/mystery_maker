class ReportGenerator
  attr_reader :witnesses, :crime_event

  def initialize(witnesses, crime_event)
    @witnesses = witnesses
    @crime_event = crime_event
  end

  def call
    CrimeSceneReport.create(
      date: crime_event.date,
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
