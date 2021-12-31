# frozen_string_literal: true

require "yaml"
require "sqlite3"
require "bundler/gem_tasks"

namespace :db do
  db_config = YAML::load(File.open("config/database.yml"))

  desc "Create the database"
  task :create do
    SQLite3::Database.new(db_config["database"])
    puts "Database created"
  end

  desc "Drop the database"
  task :drop do
    File.delete(db_config["database"]) if File.exists?(db_config["database"])
    puts "Database deleted."
  end
end

task default: %i[]
