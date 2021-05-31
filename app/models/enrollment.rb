class Enrollment < ApplicationRecord
  validates :price, presence: true
  validates :course, uniqueness: { scope: :user }

  belongs_to :course
  belongs_to :user
end
