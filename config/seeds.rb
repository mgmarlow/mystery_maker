world = YAML.safe_load(File.open("config/world.yml"))

puts "Creating people..."
people = 500.times.map { Person.create_with_random }

perp = people.sample
puts "Created perp: #{perp.name}"

witnesses = people.sample(2)
puts "#{witnesses.length} witnesses: #{witnesses.pluck(:name).join(" and ")}"

# world["locations"]
