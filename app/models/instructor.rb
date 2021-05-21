class Instructor < ApplicationRecord
  has_one_attached :profile_picture

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  has_many :courses

  def display_name
    "#{name} (#{email})"
  end
end
