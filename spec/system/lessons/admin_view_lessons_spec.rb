require 'rails_helper'

describe 'Admin view lessons' do
  it 'of a course' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10, instructor: capaldi,
                   enrollment_deadline: '22/12/2033')
    other_course = Course.create!(name: 'Ruby on Rails',
                   description: 'Um curso de Ruby on Rails',
                   code: 'RUBYONRAILS', price: 20, instructor: capaldi,
                   enrollment_deadline: '20/12/2033')

    Lesson.create!(name: 'Classes e Objetos', duration: 20, description: 'Orientação a Objetos em Ruby', course: course)
    Lesson.create!(name: 'Monkey Patch', duration: 10, description: 'Uma aula sobre Monkey Patch', course: course)
    Lesson.create!(name: 'Aula que não será mostrada', duration: 40, description: 'Descrição que não aparece', course: other_course)

    visit course_path(course)
    expect(page).to have_text('Classes e Objetos')
    expect(page).to have_text('Orientação a Objetos em Ruby')
    expect(page).to have_text('Monkey Patch')
    expect(page).to have_text('Uma aula sobre Monkey Patch')
    expect(page).to_not have_text('Aula que não será mostrada')
    expect(page).to_not have_text('Descrição que não aparece')
  end

  it 'and view details' do
    user = User.create!(email: 'estudante@codeplay.com', password: '12345678')

    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10, instructor: capaldi,
                            enrollment_deadline: '22/12/2033')

    Enrollment.create!(user: user, course: course, price: course.price)

    Lesson.create!(name: 'Classes e Objetos I', duration: 0, description: 'Orientação a Objetos em Ruby - Parte I', course: course)
    Lesson.create!(name: 'Monkey Patch', duration: 1, description: 'Uma aula sobre Monkey Patch', course: course)
    Lesson.create!(name: 'Classes e Objetos III', duration: 20, description: 'Orientação a Objetos em Ruby - Parte III', course: course)

    login_as user, scope: :user
    visit course_path(course)
    click_on 'Classes e Objetos I'  

    expect(page).to have_content('Classes e Objetos I')
    expect(page).to have_content('Orientação a Objetos em Ruby - Parte I')
    expect(page).to have_content('Sem duração')

    click_on 'Voltar'
    click_on 'Monkey Patch'

    expect(page).to have_content('Monkey Patch')
    expect(page).to have_content('Uma aula sobre Monkey Patch')
    expect(page).to have_content('1 minuto')

    click_on 'Voltar'
    click_on 'Classes e Objetos III'

    expect(page).to have_content('Classes e Objetos III')
    expect(page).to have_content('Orientação a Objetos em Ruby - Parte III')
    expect(page).to have_content('20 minutos')
  end

  it 'of a course with no lessons' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10, instructor: capaldi,
                            enrollment_deadline: '22/12/2033')

    visit course_path(course)

    expect(page).to have_content('Nenhuma aula disponível')
  end
end