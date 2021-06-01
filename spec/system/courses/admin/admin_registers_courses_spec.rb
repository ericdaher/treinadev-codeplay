require 'rails_helper'

describe 'Admin registers courses' do
  it 'from index page' do
    visit root_path
    click_on 'Cursos'

    expect(page).to have_link('Registrar um curso',
                              href: new_admin_course_path)
  end

  it 'successfully' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    visit root_path
    click_on 'Cursos'
    click_on 'Registrar um curso'

    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Descrição', with: 'Um curso de Ruby on Rails'
    select 'Peter Capaldi (peter@capaldi.com)', from: 'Professor'
    fill_in 'Código', with: 'RUBYONRAILS'
    fill_in 'Preço', with: '30'
    fill_in 'Data limite de matrícula', with: '22/12/2033'
    attach_file 'Banner', Rails.root.join('spec/fixtures/ruby_on_rails.png')
    click_on 'Criar Curso'

    expect(current_path).to eq(admin_course_path(Course.last))
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_css('img[src*="ruby_on_rails.png"]')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    visit root_path
    click_on 'Cursos'
    click_on 'Registrar um curso'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    fill_in 'Preço', with: ''
    fill_in 'Data limite de matrícula', with: ''
    click_on 'Criar Curso'

    expect(page).to have_content('não pode ficar em branco', count: 3)
    expect(page).to have_content('Professor é obrigatório')
  end

  it 'and code must be unique' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10, instructor: capaldi,
                   enrollment_deadline: '22/12/2033')

    visit root_path
    click_on 'Cursos'
    click_on 'Registrar um curso'
    fill_in 'Código', with: 'RUBYBASIC'
    click_on 'Criar Curso'

    expect(page).to have_content('já está em uso')
  end

  it 'cancels and go back' do
    visit root_path
    click_on 'Cursos'
    click_on 'Registrar um curso'
    click_on 'Voltar'
    
    expect(current_path).to eq(admin_courses_path)
  end
end