require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  let!(:user){FactoryBot.create(:user)}
  let!(:admin_user){FactoryBot.create(:admin_user)}

  describe 'ユーザー登録' do
    context '新規登録画面に遷移した場合' do
      it 'ユーザー登録がされる' do
        visit new_user_path
        fill_in 'user[name]', with: 'あだち'
        fill_in 'user[email]', with: 'adachi@gmail.com'
        fill_in 'user[password]', with: 'adachi@gmail.com'
        fill_in 'user[password_confirmation]', with: 'adachi@gmail.com'
        click_on"Create my account"
        expect(page).to have_content 'あだち'
        expect(page).to have_content 'adachi@gmail.com'
      end
    end  

    context 'ログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'Log in'
      end  
    end
  end  

  describe 'セッション機能のテスト' do
    context 'ログインした場合' do
      it '詳細画面に遷移する' do 
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_on "Log in"
        sleep(2)
        visit user_path(user)
        expect(current_path).to eq user_path(user)
      end
    end

    context '一般ユーザが他人の詳細画面に飛ぶ場合' do
      it 'タスク一覧画面に遷移する' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_on "Log in"
        visit user_path(user)
        expect(current_path).to eq user_path(user)
      end
    end

    context 'ログイン後' do
      it 'ログアウトができる' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit user_path(user)
        click_link "Logout"
        expect(current_path).to eq new_session_path
      end
    end
  end  

  describe '管理画面のテスト' do
    context '管理ユーザがログインした場合' do
      it '管理画面に遷移できる' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@gmail.com'
        fill_in 'session[password]', with: '222222'
        click_on "Log in"
        visit admin_users_path
        expect(current_path).to eq admin_users_path
        sleep(2)
      end  
    end  
    
    context '一般ユーザが管理画面にログインした場合' do
      it 'タスク一覧画面に遷移する' do
        visit new_session_path
        fill_in 'session[email]', with: 'normal@gmail.com'
        fill_in 'session[password]', with: '111111' 
        click_on "Log in"
        visit admin_users_path
        sleep(2)
        expect(current_path).not_to eq admin_users_path
      end  
    end
    
    context '管理ユーザがユーザの新規登録をした場合' do
      it 'ユーザ一覧画面に新規ユーザが表示される' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@gmail.com'
        fill_in 'session[password]', with: '222222'
        click_on "Log in"
        visit new_admin_user_path
        fill_in 'user[name]', with: 'たかはし'
        fill_in 'user[email]', with: 'takahashi@gmail.com'
        select '管理者ユーザー', from: :'user[admin]'
        fill_in 'user[password]', with: 'takahashi@gmail.com'
        fill_in 'user[password_confirmation]', with: 'takahashi@gmail.com'
        click_on "登録"
        sleep(3)
        visit admin_users_path
        expect(page).to have_content 'たかはし'
        expect(page).to have_content 'takahashi@gmail.com'
      end  
    end

    context '管理ユーザがユーザの詳細画面にアクセスした場合' do
      it 'ユーザ詳細画面が表示される' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@gmail.com'
        fill_in 'session[password]', with: '222222'
        click_on "Log in"
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end  
    end
    
    context '管理ユーザが編集画面からユーザを編集した場合' do
      it 'ユーザの情報が変更される' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@gmail.com'
        fill_in 'session[password]', with: '222222'
        click_on "Log in"
        visit admin_users_path
        visit edit_admin_user_path(user)
        fill_in 'user[password]', with: '111111'
        fill_in 'user[password_confirmation]', with: '111111'
        click_on "登録"
        visit admin_users_path
        expect(page).to have_content user.name 
      end  
    end
    
    context '管理ユーザがユーザを削除した場合' do
      it 'ユーザ一覧画面にそのユーザが表示されない' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@gmail.com'
        fill_in 'session[password]', with: '222222'
        click_on "Log in"
        visit admin_users_path
        click_on "削除", match: :first
        expect(page).to have_content 'ユーザーを削除しました'
      end  
    end
  end  
end    



#