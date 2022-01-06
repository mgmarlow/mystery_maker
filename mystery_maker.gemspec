# frozen_string_literal: true

require_relative "lib/mystery_maker/version"

Gem::Specification.new do |spec|
  spec.name = "mystery_maker"
  spec.version = MysteryMaker::VERSION
  spec.authors = ["Graham Marlow"]
  spec.email = ["mgmarlow@hey.com"]

  spec.summary = "Mystery Maker"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faker", "~> 2.19.0"
  spec.add_dependency "activerecord", "~> 7.0.0"
  spec.add_dependency "sqlite3", "~> 1.4.2"

  spec.add_development_dependency "pry", "~> 0.14.1"
  spec.add_development_dependency "pry-byebug", "~> 3.8.0"
  spec.add_development_dependency "standard", "~> 1.6.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
