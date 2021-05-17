class Instructor < ApplicationRecord
  has_one_attached :profile_picture
  
  validates_presence_of :name, :email, message: 'não pode ficar em branco'
  validates_uniqueness_of :email, message: 'já está em uso'
end
