FactoryBot.define do

  factory :user do
    name { "normaluser" }
    email { "normal@gmail.com" }
    password { "111111" }
    password_confirmation { "111111" }
    admin {false}
  end

  factory :admin_user, class: User do
    name { "adminuser" }
    email { "admin@gmail.com" }
    password { "222222" }
    password_confirmation { "222222" }
    admin {true}
  end
end