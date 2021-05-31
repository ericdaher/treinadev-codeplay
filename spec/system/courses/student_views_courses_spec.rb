require 'rails_helper'

describe 'Student view courses' do
  it 'that are still open' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    available_course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                      code: 'RUBYBASIC', price: 10, instructor: capaldi,
                                      enrollment_deadline: 1.month.from_now)
    unavailable_course = Course.create!(name: 'Ruby on Rails', description: 'Um curso de Ruby on Rails',
                                        code: 'RUBYONRAILS', price: 20, instructor: capaldi,
                                        enrollment_deadline: 1.day.ago)

    visit root_path

    expect(page).to have_content('Ruby')
    expect(page).to have_content('Um curso de Ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).to_not have_content('Ruby on Rails')
    expect(page).to_not have_content('Um curso de Ruby on Rails')
    expect(page).to_not have_content('R$ 20,00')
  end

  it 'and view enrollment link' do
    user = User.create!(email: 'peter@capaldi.com', password: '12345678')
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10, instructor: capaldi,
                   enrollment_deadline: 1.month.from_now)

    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'

    expect(page).to have_link 'Comprar'
  end

  xit 'and does not view enrollment link if deadline is over' do
  end

  it 'must be signed in to enroll' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10, instructor: capaldi,
                   enrollment_deadline: 1.month.from_now)

    visit root_path
    click_on 'Ruby'

    expect(page).to_not have_link 'Comprar'
    expect(page).to have_content 'Faça login para comprar este curso'
    expect(page).to have_link 'login', href: new_user_session_path
  end

  it 'and buy course' do
    user = User.create!(email: 'peter@capaldi.com', password: '12345678')
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10, instructor: capaldi,
                   enrollment_deadline: 1.month.from_now)
    Course.create!(name: 'Ruby on Rails', description: 'Um curso de Ruby on Rails',
                    code: 'RUBYONRAILS', price: 20, instructor: capaldi,
                    enrollment_deadline: 1.month.from_now)

    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'
    click_on 'Comprar'

    expect(page).to have_content 'Curso comprado com sucesso'
    expect(current_path).to eq(mine_courses_path)
    expect(page).to have_content 'Ruby'
    expect(page).to have_content 'R$ 10,00'
    expect(page).not_to have_content 'Ruby on Rails'
    expect(page).not_to have_content 'R$ 20,00'
  end

  it 'and cannot buy a course twice' do
    user = User.create!(email: 'peter@capaldi.com', password: '12345678')
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10, instructor: capaldi,
                   enrollment_deadline: 1.month.from_now)

    Enrollment.create!(user: user, course: course, price: course.price)

    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'

    expect(page).to_not have_link 'Comprar'
  end

  it 'and without enrollment cannot view lesson link' do
    user = User.create!(email: 'peter@capaldi.com', password: '12345678')
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
end