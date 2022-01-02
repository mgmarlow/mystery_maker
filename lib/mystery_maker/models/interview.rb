class Interview < ActiveRecord::Base
  def self.create_with_random(args={})
    defaults = {
      person: Person.create_with_random,
      transcript: Faker::Fantasy::Tolkien.poem
    }
    create(defaults.merge(args))
  end
end
