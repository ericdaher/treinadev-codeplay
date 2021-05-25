require 'rails_helper'

describe 'Admin registers lessons' do
  it 'successfully' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10, instructor: capaldi,
                            enrollment_deadline: '22/12/2033')

    visit course_path(course)
    expect(page).to have_text('Nenhuma aula disponível')
    click_on 'Registrar uma aula'

    fill_in 'Nome', with: 'Duck Typing'
    fill_in 'Duração', with: 10
    fill_in 'Descrição', with: 'Uma aula sobre duck typing'
    click_on 'Criar Aula'

    expect(page).to_not have_text('Nenhuma aula disponível')
    expect(page).to have_text('Aula cadastrada com sucesso')
    expect(page).to have_content('Duck Typing')
    expect(page).to have_text('Uma aula sobre duck typing')
    expect(current_path).to eq(course_path(course))
  end

  xit 'and attributes cannot be blank' do
    
  end
end