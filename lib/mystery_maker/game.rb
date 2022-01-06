class Game
  def run
    puts "A murder occurred at #{crime_scene_report.date} " \
         "in #{crime_scene_report.city}. " \
         "Find the perp!\n(hint: Take a look at crime_scene_reports)"
  end

  def crime_scene_report
    @crime_scene_report ||= ReportGenerator.new(witnesses, solution.murder_date).call
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
    Solution.first
  end
end
