require 'rails_helper'

describe 'Admin deletes courses' do
  it 'successfully' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10, instructor: capaldi,
                            enrollment_deadline: '22/12/2033')

    visit admin_course_path(course)
    expect { click_on 'Excluir' }.to change { Course.count }.by(-1)

    expect(page).to have_text('Curso excluído com sucesso')
    expect(current_path).to eq(admin_courses_path)
  end
end
