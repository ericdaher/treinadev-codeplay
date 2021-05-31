class Course < ApplicationRecord
  has_one_attached :banner

  validates :name, :code, :price, presence: true
  validates :code, uniqueness: true
  validates :price, numericality: { greater_than: 0 }

  belongs_to :instructor
  has_many :lessons
  has_many :enrollments
  has_many :users, through: :enrollments

  scope :available, -> { where(enrollment_deadline: Date.current..) }
end
