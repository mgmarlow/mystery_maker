# frozen_string_literal: true

require "yaml"
require "faker"
require "active_record"

require_relative "scripts/initializer"
require_relative "mystery_maker/version"
require_relative "mystery_maker/game"
require_relative "mystery_maker/world"
require_relative "mystery_maker/helpers"
require_relative "mystery_maker/cli"
Dir[File.join(__dir__, "/mystery_maker/models/*.rb")].each { |file| require_relative file }
Dir[File.join(__dir__, "/mystery_maker/generators/*.rb")].each { |file| require_relative file }

module MysteryMaker
  class Error < StandardError; end
  # Your code goes here...
end
