module MysteryMaker
  class CLI
    def start
      unless seeded?
        require "rake"
        Rake.application.load_rakefile
        Rake::Task["db:seed"].invoke
      end

      puts "#{"*" * 10}\n"
      puts "A murder occurred at #{Helpers.solution.murder_date} " \
        "in SQL City. Find the perp!\n" \
        "(hint: check crime_scene_reports)"
      puts "#{"*" * 10}\n"

      exec "sqlite3 mystery.db"
    end

    def seeded?
      Solution.all.count > 0
    end
  end
end
