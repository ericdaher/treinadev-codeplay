require 'rails_helper'

describe 'Account management' do
  context 'sign up' do
    it 'with email and password' do
      visit root_path
      click_on 'Registrar'
      fill_in 'Email', with: 'peter@capaldi.com'
      fill_in 'Senha', with: '12345678'
      fill_in 'Confirmar senha', with: '12345678'
      click_on 'Criar Conta'

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('peter@capaldi.com')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Registrar')
      expect(page).to have_link('Sair')
    end

    xit 'with invalid fields' do
      
    end

    xit 'password not matching confirmation' do
      
    end

    xit 'email must be unique' do
      
    end
  end
  
  context 'sign in' do
    it 'with email and password' do
      User.create!(email: 'peter@capaldi.com', password: '12345678')

      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: 'peter@capaldi.com'
      fill_in 'Senha', with: '12345678'
      within 'form' do
        click_on 'Fazer Login'
      end

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('peter@capaldi.com')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Registrar')
      expect(page).to_not have_link('Entrar')
      expect(page).to have_link('Sair')
    end
  end

  context 'logout' do
    it 'successfully' do
      user = User.create!(email: 'peter@capaldi.com', password: '12345678')

      login_as user, scope: :user
      visit root_path
      click_on 'Sair'

      expect(page).to have_text('Saiu com sucesso')
      expect(page).to_not have_text('peter@capaldi.com')
      expect(current_path).to eq(root_path)
      expect(page).to have_link('Registrar')
      expect(page).to have_link('Entrar')
      expect(page).to_not have_link('Sair')
    end
  end
end