require 'rails_helper'

describe Course do
  context 'validation' do
    it 'attributes cannot be blank' do
      course = Course.new

      course.valid?

      expect(course.errors[:name]).to include('não pode ficar em branco')
      expect(course.errors[:code]).to include('não pode ficar em branco')
      expect(course.errors[:price]).to include('não pode ficar em branco')
    end

    it 'code must be uniq' do
      capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                   bio: 'Twelfth Doctor')

      Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                     code: 'RUBYBASIC', price: 10, instructor: capaldi,
                     enrollment_deadline: '22/12/2033')
      course = Course.new(code: 'RUBYBASIC')

      course.valid?

      expect(course.errors[:code]).to include('já está em uso')
    end

    it 'price must be positive' do
      course = Course.new(price: 0)

      course.valid? 

      expect(course.errors[:price]).to include('deve ser maior que 0')
    end
  end
end