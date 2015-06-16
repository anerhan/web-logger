FactoryGirl.define do
  factory :user do
    first_name 'Dmitriy'
    last_name 'Bielorusov'
    email 'user@gmail.com'
    position 0
    password "password"
    password_confirmation { |u| u.password }
  end
  factory :admin, class: User do
    first_name 'Dmitriy'
    last_name 'Bielorusov'
    email 'admin@gmail.com'
    position 3
    password "password"
    password_confirmation { |u| u.password }
  end
end
