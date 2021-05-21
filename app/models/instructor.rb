class Instructor < ApplicationRecord
  has_one_attached :profile_picture

  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
