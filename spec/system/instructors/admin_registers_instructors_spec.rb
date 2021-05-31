require 'rails_helper'

describe 'Admin registers instructors' do
  it 'from index page' do
    visit root_path
    click_on 'Professores'

    expect(page).to have_link('Registrar um professor',
                              href: new_instructor_path)
  end

  it 'successfully' do
    visit root_path
    click_on 'Professor'
    click_on 'Registrar um professor'

    fill_in 'Nome', with: 'Peter Capaldi'
    fill_in 'Email', with: 'peter@capaldi.com'
    fill_in 'Descrição', with: 'Twelfth Doctor'
    attach_file 'Foto de Perfil', Rails.root.join('spec/fixtures/capaldi.jpg')
    click_on 'Criar Professor'

    expect(current_path).to eq(instructor_path(Instructor.last))
    expect(page).to have_css("img[src*='capaldi.jpg']")
    expect(page).to have_content('Peter Capaldi')
    expect(page).to have_content('peter@capaldi.com')
    expect(page).to have_content('Twelfth Doctor')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    visit root_path
    click_on 'Professores'
    click_on 'Registrar um professor'
    
    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Criar Professor'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and email must be unique' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    capaldi.profile_picture.attach(io: File.open('spec/fixtures/capaldi.jpg'),
                                   filename: 'capaldi.jpg' )

    visit root_path
    click_on 'Professores'
    click_on 'Registrar um professor'
    fill_in 'Email', with: 'peter@capaldi.com'
    click_on 'Criar Professor'

    expect(page).to have_content('já está em uso')
  end

  it 'cancels and go back' do
    visit root_path
    click_on 'Professores'
    click_on 'Registrar um professor'
    click_on 'Voltar'
    
    expect(current_path).to eq(instructors_path)
  end
end