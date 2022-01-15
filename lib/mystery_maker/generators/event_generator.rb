class EventGenerator
  attr_reader :world

  def initialize(world)
    @world = world
  end

  def call
    world["events"].each do |data|
      location = Location.find_by(name: data["location"])

      events = create_time_windows.map do |window|
        date, start_time, end_time = window

        Event.create(
          name: data["name"],
          location: location,
          date: date,
          start_time: start_time,
          end_time: end_time
        )
      end

      # Add 15 people to each event
      events.each do |event|
        Person.all.sample(15).each do |person|
          person.events << event
        end
      end
    end
  end

  private

  # Each event occurred 5 times during the week at random 1-hr intervals.
  def create_time_windows
    (0..2300).step(100).to_a.sample(5).map do |start_time|
      [Helpers.create_date, start_time, start_time + 100]
    end
  end
end
