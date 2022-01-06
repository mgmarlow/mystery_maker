class Person < ActiveRecord::Base
  has_one :drivers_license
  has_and_belongs_to_many :events
end
