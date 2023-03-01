 User.create!(
  name: "管理者",
  email: "admin@example.com",
  password: "admin@example.com",
  password_confirmation: "admin@example.com",
  admin: true
 )

User.create(name: 'seed1', email: 'seed1@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
User.create(name: 'seed2', email: 'seed2@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
User.create(name: 'seed3', email: 'seed3@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
User.create(name: 'seed4', email: 'seed4@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
User.create(name: 'seed5', email: 'seed5@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
User.create(name: 'seed6', email: 'seed6@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
User.create(name: 'seed7', email: 'seed7@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
User.create(name: 'seed8', email: 'seed8@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
User.create(name: 'seed9', email: 'seed9@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
User.create(name: 'seed10', email: 'seed10@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')

10.times do |i|
    Task.create!(title: "タイトル", content: "ジンジャーエール", deadline: "2023-03-01", priority: "低", status: "未着手", user_id: 7)
  end

labels = Label.all
labels = labels.map{|label| label.id}  
10.times do |i|
    Label.create!(label_name: "LABEL#{i+1}")
  end