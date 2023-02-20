require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        
        task = FactoryBot.create(:task)
        visit new_task_path
        fill_in 'task[content]', with: 'task'
        fill_in 'task[title]', with: 'task'
        fill_in 'task[deadline]', with: '002023-02-10'
        select '完了', from:'task[status]'
        select '高', from:'task[priority]'
        #sleep(3)
        click_on '登録する'
        expect(page).to have_content 'task'
        expect(page).to have_content '完了'
        expect(page).to have_content '高'
        expect(page).to have_content '2023-02-10 00:00:00 +0900' 

      end
    end
  end  

    describe '一覧表示機能' do
      context '一覧画面に遷移した場合' do
        it '作成済みのタスク一覧が表示される' do
          # テストで使用するためのタスクを作成
          task = FactoryBot.create(:task)
          # タスク一覧ページに遷移
          visit tasks_path
          # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
          # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
          expect(page).to have_content 'タスク1'
          # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
        end
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_1 = FactoryBot.create(:task, title: "タスク1")
        task_2 = FactoryBot.create(:task, title: "タスク2")
        visit tasks_path
        task_list = all('.task_row')
        #sleep(5)        
        expect(task_list[0]).to have_content task_2.title
      end
    end

    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限が近いものから表示する' do
        task = FactoryBot.create(:task, title: "タスク1", deadline: "2023-02-10" )
        visit tasks_path
        click_on '終了期限でソートする'
        task_list = all('.task_row')
        sleep(5)
        expect(task_list.first).to have_content "タスク1"
      end
    end    


    describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task)
         visit tasks_path
         click_on '詳細を確認する'
         expect(page).to have_content 'タスク1'
         #sleep(5)
         click_on '戻る'
         click_on 'ブログ一覧画面にもどる'
       end
     end
  end
end