# frozen_string_literal: true

require "yaml"
require "faker"
require "active_record"

db_config = YAML.safe_load(File.open("config/database.yml"))
ActiveRecord::Base.establish_connection(db_config)

require_relative "mystery_maker/version"
Dir[File.join(__dir__, "/mystery_maker/models/*.rb")].each { |file| require_relative file }
Dir[File.join(__dir__, "/mystery_maker/clues/*.rb")].each { |file| require_relative file }

module MysteryMaker
  class Error < StandardError; end
  # Your code goes here...
end
