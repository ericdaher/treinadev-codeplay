require 'rails_helper'

describe 'Student view lessons' do
  it 'successfully' do
    user = User.create!(email: 'estudante@codeplay.com', password: '12345678')
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10, instructor: capaldi,
                            enrollment_deadline: 1.month.from_now)

    Lesson.create!(name: 'Classes e Objetos', duration: 20, description: 'Orientação a Objetos em Ruby', course: course)
    Enrollment.create!(user: user, course: course, price: course.price)

    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'
    click_on 'Classes e Objetos'

    expect(page).to have_content('Classes e Objetos')
    expect(page).to have_content('Orientação a Objetos em Ruby')
    expect(page).to have_content('20 minutos')
  end

  it 'and without enrollment cannot view lesson link' do
    user = User.create!(email: 'estudante@codeplay.com', password: '12345678')
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10, instructor: capaldi,
                            enrollment_deadline: 1.month.from_now)

    Lesson.create!(name: 'Classes e Objetos', duration: 20, description: 'Orientação a Objetos em Ruby', course: course)

    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'

    expect(page).to have_content 'Classes e Objetos'
    expect(page).to_not have_link 'Classes e Objetos'
  end

  it 'without login cannot view lesson' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10, instructor: capaldi,
                            enrollment_deadline: 1.month.from_now)

    lesson = Lesson.create!(name: 'Classes e Objetos', duration: 20, description: 'Orientação a Objetos em Ruby',
                            course: course)

    visit course_lesson_path(course, lesson)

    expect(current_path).to eq(new_user_session_path)
  end

  it 'without enrollment cannot view lesson' do
    user = User.create!(email: 'estudante@codeplay.com', password: '12345678')
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10, instructor: capaldi,
                            enrollment_deadline: 1.month.from_now)

    lesson = Lesson.create!(name: 'Classes e Objetos', duration: 20, description: 'Orientação a Objetos em Ruby',
                            course: course)

    login_as user, scope: :user
    visit course_lesson_path(course, lesson)

    expect(current_path).to eq(course_path(course))
    expect(page).to have_link 'Comprar'
  end

  it 'directly' do
    user = User.create!(email: 'estudante@codeplay.com', password: '12345678')
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10, instructor: capaldi,
                            enrollment_deadline: 1.month.from_now)

    lesson = Lesson.create!(name: 'Classes e Objetos', duration: 20, description: 'Orientação a Objetos em Ruby',
                            course: course)
    Enrollment.create!(user: user, course: course, price: course.price)

    login_as user, scope: :user
    visit course_lesson_path(course, lesson)

    expect(page).to have_content('Classes e Objetos')
    expect(page).to have_content('Orientação a Objetos em Ruby')
    expect(page).to have_content('20 minutos')
  end
end
