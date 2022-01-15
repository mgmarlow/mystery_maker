class World
  def [](key)
    data[key]
  end

  def data
    @data ||= YAML.safe_load(File.open("config/world.yml"))
  end
end
