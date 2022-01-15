module MysteryMaker
  class Game
    def self.prepare
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
  end
end
