module MysteryMaker
  class Game
    class << self
      def prepare
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

      def witnesses
        perp_id = active_scenario.person.id
        active_scenario.event.people
          .filter { |p| p.id != perp_id }
          .take(2)
      end

      # Always assume there's just one scenario active.
      def active_scenario
        Scenario.first
      end
    end
  end
end
