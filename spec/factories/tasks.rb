FactoryBot.define do
  factory :task do
    title { 'タスク1' }
    content { 'タスク1の内容' }
    deadline { '2023/2/10' }
    status { '未着手' }
    priority { '低' }
  end  

  factory :second_task, class: Task do
    title { 'sample' }
    content { 'タスク2の内容' }
    deadline { '2023/2/10' }
    status { '完了' }
    priority { '低' }  
  end
end
