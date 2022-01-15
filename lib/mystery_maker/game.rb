class Game
  def first_time_setup
    world = World.new

    # NOTE: Order matters.
    [
      PersonGenerator.new(world),
      LocationGenerator.new(world),
      EventGenerator.new(world),
      SolutionGenerator.new,
      ReportGenerator.new(world),
      InterviewGenerator.new
    ].each(&:call)
  end

  def run
    puts "A murder occurred at #{Helpers.solution.murder_date} " \
     "in SQL City. Find the perp!" \
     "\n(hint: try 'sqlite3 mystery.db')"
  end
end
