$db_config = YAML.safe_load(File.open("config/database.yml"))

def prepared?
  File.exist?($db_config["database"])
end

unless prepared?
  require "rake"
  Rake.application.load_rakefile
  Rake::Task["db:create"].invoke
end

ActiveRecord::Base.establish_connection($db_config)
