require 'rails_helper'

describe 'Visitor visit homepage' do
  xit 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Boas vindas ao sistema de gestão de cursos e aulas')
  end
end