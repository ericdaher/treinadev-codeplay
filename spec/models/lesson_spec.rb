require 'rails_helper'

describe Lesson do
  context 'validations' do
    it 'attributes cannot be blank' do
      lesson = Lesson.new

      lesson.valid?

      expect(lesson.errors[:name]).to include('não pode ficar em branco')
      expect(lesson.errors[:description]).to include('não pode ficar em branco')
      expect(lesson.errors[:duration]).to include('não pode ficar em branco')
      expect(lesson.errors[:course]).to include('é obrigatório(a)')
    end

    it 'duration must be positive' do
      lesson = Lesson.new(duration: -1)

      lesson.valid?

      expect(lesson.errors[:duration]).to include('deve ser maior ou igual a 0')
    end
  end
end
