class CrimeSceneReport < ActiveRecord::Base
  self.inheritance_column = "klass_type"

  def self.create_with_random(args={})
    FactoryBot.create(:crime_scene_report, *args)
    defaults = {
      date: begin
        check_in = Faker::Date.between_except(from: '2010-01-01', to: '2022-01-01')
        check_in.strftime("%Y%m%d")
      end,
      type: %w[murder robbery theft fraud arson smuggling blackmail].sample,
      description: Faker::Fantasy::Tolkien.unique.poem,
      city: Faker::Address.city
    }
    create(defaults.merge(args))
  end
end
