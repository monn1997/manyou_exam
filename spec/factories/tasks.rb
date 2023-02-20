FactoryBot.define do
  factory :task do
    title { 'タスク1' }
    content { 'タスク1の内容' }
    deadline { '2023/2/10' }
    status { '未着手' }
    priority { '低' }
  end
end
