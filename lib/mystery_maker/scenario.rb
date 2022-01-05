module MysteryMaker
  MURDER_DATE = 20180115

  module Scenario
    def self.included(base)
      base.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods
      def crime_scene_report(*scenario_clues)
        scenario_clues.each { |clue| clues.push(clue) }
      end

      def after_setup(&block)
        after_hooks << block
      end

      def clues
        @clues ||= []
      end

      def after_hooks
        @after_hooks ||= []
      end
    end

    def initialize
      assemble_report
      self.class.after_hooks.each  { |hook| instance_exec(&hook) }
    end

    def assemble_report
      desc = "Security footage shows that there were #{self.class.clues.length} witnesses."
      report = self.class.clues.inject(desc) do |acc, clue|
        acc + " " + clue.new(perp).setup
      end

      CrimeSceneReport.create({
        description: report,
        type: "murder",
        city: "SQL City",
        date: MURDER_DATE
      })     
    end

    def perp
      @perp ||= Person.create_with_random
    end
  end
end
