require 'rails_helper'
RSpec.describe 'ラベル検索機能', type: :system do
  let!(:user){FactoryBot.create(:user)}
  let!(:label){FactoryBot.create(:label)}

  def login
    visit new_session_path
      fill_in 'session[email]', with: 'normal@gmail.com'
      fill_in 'session[password]', with: '111111'
      click_on 'Log in'
  end    

  describe 'ラベル登録' do
    context 'タスクを新規登録した場合' do
      it 'ラベル登録がされる' do
        task = FactoryBot.create(:task, user_id: user.id)
        login
        sleep(3)
        visit new_task_path
        fill_in 'task[title]', with: '登録します'
        fill_in 'task[content]', with: 'touroku'
        fill_in "task[deadline]", with: '002023-03-01'
        select '未着手', from: 'task[status]'
        select '高', from: 'task[priority]'
        check 'LABEL1'
        click_on '登録する'
        click_on '登録する'
        expect(page).to have_content '登録します'
        expect(page).to have_content 'touroku'
        expect(page).to have_content 'LABEL1'
      end
    end
    
    context 'タスクを新規登録した場合' do
      it 'ラベル登録がされる' do
        visit new_session_path
        login
        visit new_task_path
        fill_in 'task[title]', with: '登録します'
        fill_in 'task[content]', with: 'touroku'
        fill_in "task[deadline]", with: '002023-03-01'
        select '未着手', from: 'task[status]'
        select '高', from: 'task[priority]'
        check 'LABEL1'
        click_on '登録する'
        click_on '登録する'
        click_link '編集する'
        sleep(3)
        page.accept_confirm
        fill_in 'task[title]', with: '編集します'
        fill_in 'task[content]', with: 'hensyu'
        fill_in "task[deadline]", with: '002023-03-02'
        select '着手中', from: 'task[status]'
        select '中', from: 'task[priority]'
        check 'LABEL1'
        click_on '更新する'
        expect(page).to have_content '編集します'
        expect(page).to have_content 'hensyu'
        expect(page).to have_content 'LABEL1' 
      end  
    end  

    context '一覧画面の詳細ボタンを押した場合' do
      it '詳細画面が表示される' do
        visit new_session_path
        login
        visit new_task_path
        fill_in 'task[title]', with: '登録します'
        fill_in 'task[content]', with: 'touroku'
        fill_in "task[deadline]", with: '002023-03-01'
        select '未着手', from: 'task[status]'
        select '高', from: 'task[priority]'
        check 'LABEL1'
        click_on '登録する'
        click_on '登録する'
        click_link '詳細を確認する'
        expect(page).to have_content '登録します'
        expect(page).to have_content 'touroku'
        expect(page).to have_content 'LABEL1' 
      end
    end 

    context '絞り込み検索でラベルを選択した場合' do
      it 'ラベル検索がされる' do
        visit new_session_path
        login
        visit new_task_path
        fill_in 'task[title]', with: '登録します'
        fill_in 'task[content]', with: 'touroku'
        fill_in "task[deadline]", with: '002023-03-01'
        select '未着手', from: 'task[status]'
        select '高', from: 'task[priority]'
        check 'LABEL1'
        click_on '登録する'
        click_on '登録する'
        select 'LABEL1', from: 'task[label_ids]'
        click_on '検索'
        expect(page).to have_content 'LABEL1' 
      end
    end
  end
end     
    



