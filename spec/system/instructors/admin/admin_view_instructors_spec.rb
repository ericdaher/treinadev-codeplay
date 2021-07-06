require 'rails_helper'

describe 'Admin view instructors' do
  it 'successfully' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    clara = Instructor.create!(name: 'Clara Oswald', email: 'clara@oswald.com',
                               bio: 'Impossible Girl')

    capaldi.profile_picture.attach(io: File.open('spec/fixtures/capaldi.jpg'),
                                   filename: 'capaldi.jpg')

    clara.profile_picture.attach(io: File.open('spec/fixtures/clara.jpg'),
                                 filename: 'clara.jpg')

    visit admin_root_path
    click_on 'Professores'

    expect(page).to have_content('Peter Capaldi')
    expect(page).to have_content('Twelfth Doctor')
    expect(page).to have_content('Clara Oswald')
    expect(page).to have_content('Impossible Girl')
  end

  it 'with details' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    capaldi.profile_picture.attach(io: File.open('spec/fixtures/capaldi.jpg'),
                                   filename: 'capaldi.jpg')

    visit admin_root_path
    click_on 'Professores'
    click_on 'Peter Capaldi'

    expect(page).to have_content('Peter Capaldi')
    expect(page).to have_css("img[src*='capaldi.jpg']")
    expect(page).to have_content('peter@capaldi.com')
    expect(page).to have_content('Twelfth Doctor')
  end

  it 'and no course is available' do
    visit admin_root_path
    click_on 'Professores'

    expect(page).to have_content('Nenhum professor cadastrado')
  end

  it 'and return to home page' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    capaldi.profile_picture.attach(io: File.open('spec/fixtures/capaldi.jpg'),
                                   filename: 'capaldi.jpg')

    visit admin_root_path
    click_on 'Cursos'
    click_on 'Voltar'

    expect(current_path).to eq admin_root_path
  end
end
