require 'rails_helper'

describe Instructor do
  context 'validation' do
    it 'attributes cannot be blank' do
      instructor = Instructor.new

      instructor.valid?

      expect(instructor.errors[:name]).to include('não pode ficar em branco')
      expect(instructor.errors[:email]).to include('não pode ficar em branco')
    end

    it 'email must be uniq' do
      capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                   bio: 'Twelfth Doctor')

      capaldi.profile_picture.attach(io: File.open('spec/fixtures/capaldi.jpg'),
                                     filename: 'capaldi.jpg')

      instructor = Instructor.new(email: 'peter@capaldi.com')

      instructor.valid?

      expect(instructor.errors[:email]).to include('já está em uso')
    end
  end
end
