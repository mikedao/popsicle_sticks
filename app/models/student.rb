class Student < ApplicationRecord
  belongs_to :mod

  validates_presence_of :name, :pronouns

  def self.enabled
    where(enabled: true)
  end

  def self.random_weighted
    ids = enabled.pluck(:id) * 2

    where('called_on_count > ?', 0).each do |student|
      ids.slice!(ids.index(student.id))
    end

   find(ids.shuffle.pop)
  end
end