module MysteryMaker
  class InterviewGenerator
    def call
      first_transcript = "I heard a gunshot when I was at #{crime_event.name} on #{crime_event.date}."
      Interview.create(person_id: witnesses.first.id, transcript: first_transcript)

      perp_license = perp.drivers_license
      plate_hint = perp_license.plate_number[0, 3]
      hair_hint = perp_license.hair_color
      second_transcript = "I saw someone get into a car that starts with '#{plate_hint}'. They had #{hair_hint}-colored hair."
      Interview.create(person_id: witnesses.second.id, transcript: second_transcript)

      generate_noise
    end

    private

    def witnesses
      Game.witnesses
    end

    def crime_event
      Game.active_scenario.event
    end

    def perp
      Game.active_scenario.person
    end

    def generate_noise
      (Person.all - witnesses).sample(100).each do |unrelated_person|
        Interview.create(person_id: unrelated_person.id, transcript: Faker::Lorem.sentence)
      end
    end
  end
end
