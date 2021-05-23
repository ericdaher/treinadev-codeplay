require 'rails_helper'

describe 'Admin edits instructors' do
  it 'successfully' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    capaldi.profile_picture.attach(io: File.open('spec/fixtures/capaldi.jpg'),
                                   filename: 'capaldi.jpg' )

    visit root_path
    click_on 'Professor'
    click_on 'Peter Capaldi'
    click_on 'Editar'

    fill_in 'Nome', with: 'Clara Oswald'
    fill_in 'Email', with: 'clara@oswald.com'
    fill_in 'Descrição', with: 'Impossible Girl'
    attach_file 'Foto de Perfil', Rails.root.join('spec/fixtures/clara.jpg')
    click_on 'Atualizar Professor'

    expect(current_path).to eq(instructor_path(Instructor.last))
    expect(page).to have_css("img[src*='clara.jpg']")
    expect(page).to have_content('Clara Oswald')
    expect(page).to have_content('clara@oswald.com')
    expect(page).to have_content('Impossible Girl')
    expect(page).to have_text('Professor atualizado com sucesso')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    capaldi.profile_picture.attach(io: File.open('spec/fixtures/capaldi.jpg'),
                                   filename: 'capaldi.jpg' )

    visit root_path
    click_on 'Professores'
    click_on 'Peter Capaldi'
    click_on 'Editar'
    
    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Atualizar Professor'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and email must be unique' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    clara = Instructor.create!(name: 'Clara Oswald', email: 'clara@oswald.com',
                                 bio: 'Impossible Girl')

    capaldi.profile_picture.attach(io: File.open('spec/fixtures/capaldi.jpg'),
                                   filename: 'capaldi.jpg' )

    clara.profile_picture.attach(io: File.open('spec/fixtures/clara.jpg'),
                                 filename: 'clara.jpg')
    
    visit root_path
    click_on 'Professores'
    click_on 'Peter Capaldi'
    click_on 'Editar'

    fill_in 'Email', with: 'clara@oswald.com'
    click_on 'Atualizar Professor'

    expect(page).to have_content('já está em uso')
  end
end