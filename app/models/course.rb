class Course < ApplicationRecord
  has_one_attached :banner

  validates :name, :code, :price, presence: true
  validates :code, uniqueness: true

  belongs_to :instructor
  has_many :lessons
end
