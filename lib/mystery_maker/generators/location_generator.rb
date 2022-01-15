class LocationGenerator
  attr_reader :world

  def initialize(world)
    @world = world
  end

  def call
    world["locations"].map { |l| Location.create(name: l) }
  end
end
