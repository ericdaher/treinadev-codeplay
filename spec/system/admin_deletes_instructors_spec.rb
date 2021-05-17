require 'rails_helper'

describe 'Admin view instructors' do
  it 'successfully' do
    capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

    clara = Instructor.create!(name: 'Clara Oswald', email: 'clara@oswald.com',
                               bio: 'Impossible Girl')

    capaldi.profile_picture.attach(
      io: File.open('spec/fixtures/capaldi.jpg'),
      filename: 'capaldi.jpg'
    )

    clara.profile_picture.attach(
      io: File.open('spec/fixtures/clara.jpg'),
      filename: 'clara.jpg'
    )

    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Peter Capaldi')
    expect(page).to have_content('Twelfth Doctor')
    expect(page).to have_content('Clara Oswald')
    expect(page).to have_content('Impossible Girl')

    click_on 'Peter Capaldi'
    click_on 'Excluir'
    
    expect(page).to_not have_content('Peter Capaldi')
    expect(page).to_not have_content('Twelfth Doctor')
    expect(page).to have_content('Clara Oswald')
    expect(page).to have_content('Impossible Girl')
  end
end