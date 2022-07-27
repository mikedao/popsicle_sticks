class Student < ApplicationRecord
  belongs_to :mod

  validates_presence_of :name, :pronouns

  def self.enabled
    where(enabled: true)
  end
end