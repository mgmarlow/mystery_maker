# frozen_string_literal: true

require "yaml"
require "faker"
require "factory_bot"
require "active_record"

db_config = YAML::load(File.open("config/database.yml"))
ActiveRecord::Base.establish_connection(db_config)

require_relative "mystery_maker/version"
require_relative "mystery_maker/models"
require_relative "mystery_maker/scenario_a"

module MysteryMaker
  include FactoryBot::Syntax::Methods

  class Error < StandardError; end
  # Your code goes here...
end
