class WitnessInterviewGenerator
  attr_reader :witnesses, :crime_event

  def initialize(witnesses, crime_event)
    @witnesses = witnesses
    @crime_event = crime_event
  end

  def call
    transcript = "I heard a gunshot when I was at #{crime_event.name} on #{crime_event.date}."

    Interview.create(person_id: witnesses.first.id, transcript: transcript)
  end
end
