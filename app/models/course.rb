class Course < ApplicationRecord
  validates_presence_of :name, :code, :price, message: 'não pode ficar em branco'
  validates_uniqueness_of :code, message: 'já está em uso'
end
