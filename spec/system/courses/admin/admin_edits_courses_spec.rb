require 'rails_helper'

describe 'Admin edits courses' do
  it 'successfully' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10, instructor: capaldi,
                            enrollment_deadline: '22/12/2033')

    visit admin_course_path(course)
    click_on 'Editar'
    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Descrição', with: 'Um curso de RoR'
    fill_in 'Código', with: 'RUBYONRAILS'
    fill_in 'Preço', with: '30'
    fill_in 'Data limite de matrícula', with: Date.current.strftime('%d/%m/%Y')
    click_on 'Atualizar Curso'

    expect(page).to have_text('Ruby on Rails')
    expect(page).to have_text('Um curso de RoR')
    expect(page).to have_text('RUBYONRAILS')
    expect(page).to have_text('R$ 30,00')
    expect(page).to have_text(Date.current.strftime('%d/%m/%Y'))
    expect(page).to have_text('Curso atualizado com sucesso')
  end

  it 'and changes instructor' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    clara = Instructor.create!(name: 'Clara Oswald', email: 'clara@oswald.com',
                               bio: 'Impossible Girl')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10, instructor: capaldi,
                            enrollment_deadline: '22/12/2033')

    visit admin_course_path(course)
    click_on 'Editar'
    select 'Clara Oswald (clara@oswald.com)', from: 'Professor'
    click_on 'Atualizar Curso'

    expect(page).to have_text('Clara Oswald')
  end

  it 'cancels and go back' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10, instructor: capaldi,
                            enrollment_deadline: '22/12/2033')

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'
    click_on 'Editar'
    click_on 'Voltar'
    
    expect(current_path).to eq(admin_course_path(course))
  end

  it 'renders edit form after errors' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10, instructor: capaldi,
                            enrollment_deadline: '22/12/2033')

    visit admin_course_path(course)
    click_on 'Editar'
    fill_in 'Preço', with: '0'
    click_on 'Atualizar Curso'

    expect(current_path).to eq(admin_course_path(course))
  end
end 