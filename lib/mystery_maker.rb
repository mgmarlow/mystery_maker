# frozen_string_literal: true

require "ostruct"
require "faker"
require "factory_bot"
require_relative "mystery_maker/version"
require_relative "mystery_maker/factories"

module MysteryMaker
  include FactoryBot::Syntax::Methods

  class Error < StandardError; end
  # Your code goes here...
end
