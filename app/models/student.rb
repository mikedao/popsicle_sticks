class Student < ApplicationRecord
  belongs_to :mod

  validates_presence_of :name, :pronouns
end