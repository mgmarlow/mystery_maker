class Game
  def first_time_setup
    [
      ReportGenerator.new(witnesses, solution.murder_date),
      WitnessInterviewGenerator.new(witnesses, solution.event)
    ].each(&:call)
  end

  def run
    puts "A murder occurred at #{solution.murder_date} " \
     "in SQL City. Find the perp!" \
     "\n(hint: Take a look at crime_scene_reports)"
  end

  def witnesses
    # Find witnesses who went to the event where the crime took place.
    @witnesses ||= solution.event.people
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
