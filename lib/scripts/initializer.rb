DB_CONFIG = YAML.safe_load(File.open("config/database.yml"))

def prepared?
  File.exist?(DB_CONFIG["database"])
end

unless prepared?
  require "rake"
  Rake.application.load_rakefile
  Rake::Task["db:create"].invoke
end

ActiveRecord::Base.establish_connection(DB_CONFIG)
