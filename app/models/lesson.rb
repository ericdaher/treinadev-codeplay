class Lesson < ApplicationRecord
  validates :name, :description, :duration, presence: true
  validates :duration, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :course
end
