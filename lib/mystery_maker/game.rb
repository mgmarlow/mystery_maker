class Game
  def first_time_setup
    [
      ReportGenerator.new(witnesses, solution.murder_date)
    ].each(&:call)
  end

  def run
    puts "A murder occurred at #{solution.murder_date} " \
     "in SQL City. Find the perp!" \
     "\n(hint: Take a look at crime_scene_reports)"
  end

  def witnesses
    # Find any people that went to the same events as the perp.
    @witnesses ||= perp.events
      .flat_map { |event| Event.find(event.id).people }
      .filter { |p| p.id != perp.id }
      .sample(2)
  end

  def perp
    @perp ||= solution.person
  end

  def solution
    @solution ||= Solution.first
  end
end
