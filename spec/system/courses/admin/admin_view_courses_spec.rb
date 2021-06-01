require 'rails_helper'

describe 'Admin view courses' do
  it 'successfully' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10, instructor: capaldi,
                   enrollment_deadline: '22/12/2033')
    Course.create!(name: 'Ruby on Rails',
                   description: 'Um curso de Ruby on Rails',
                   code: 'RUBYONRAILS', price: 20, instructor: capaldi,
                   enrollment_deadline: '20/12/2033')

    visit root_path
    click_on 'Cursos'

    expect(page).to have_content('Ruby')
    expect(page).to have_content('Um curso de Ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('R$ 20,00')
  end

  it 'and view details' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10, instructor: capaldi,
                   enrollment_deadline: '22/12/2033')
    Course.create!(name: 'Ruby on Rails',
                   description: 'Um curso de Ruby on Rails',
                   code: 'RUBYONRAILS', price: 20,
                   enrollment_deadline: '20/12/2033', instructor: capaldi,
                   banner: fixture_file_upload(Rails.root.join('spec/fixtures/ruby_on_rails.png'), 'ruby_on_rails.png'))

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby on Rails'

    expect(page).to have_css('img[src*="ruby_on_rails.png"]')
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Peter Capaldi')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 20,00')
    expect(page).to have_content('20/12/2033')
  end

  it 'and no course is available' do
    visit root_path
    click_on 'Cursos'

    expect(page).to have_content('Nenhum curso disponível')
  end

  it 'and return to home page' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10, instructor: capaldi,
                   enrollment_deadline: '22/12/2033')

    visit root_path
    click_on 'Cursos'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and return to courses page' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10, instructor: capaldi,
                   enrollment_deadline: '22/12/2033')

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'
    click_on 'Voltar'

    expect(current_path).to eq admin_courses_path
  end
end
