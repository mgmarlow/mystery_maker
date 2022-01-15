module MysteryMaker
  class SolutionGenerator
    def call
      # Select a random person that has events.
      perp = people_with_events.sample
      # Select one of the person's events as the crime scene.
      crime_event = perp.events.sample
      murder_date = crime_event.date

      Scenario.create(
        person: perp,
        murder_date: murder_date,
        event: crime_event
      )
    end

    private

    def people_with_events
      Person.joins(:events).group("people.id")
    end
  end
end
