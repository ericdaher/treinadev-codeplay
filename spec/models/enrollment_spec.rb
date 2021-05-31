require 'rails_helper'

describe Enrollment do
  context 'validation' do
    it 'attributes cannot be blank' do
      enrollment = Enrollment.new

      enrollment.valid?

      expect(enrollment.errors[:course]).to include('é obrigatório(a)')
      expect(enrollment.errors[:user]).to include('é obrigatório(a)')
      expect(enrollment.errors[:price]).to include('não pode ficar em branco')
    end

    it 'course and user must be uniq' do
      user = User.create!(email: 'estudante@codeplay.com', password: '12345678')
      capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                   bio: 'Twelfth Doctor')

      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', price: 10, instructor: capaldi,
                              enrollment_deadline: 1.month.from_now)
      
      Enrollment.create!(user: user, course: course, price: course.price)
      enrollment = Enrollment.new(user: user, course: course, price: course.price)

      enrollment.valid?

      expect(enrollment.errors[:course]).to include('já está em uso')
    end
  end
end
