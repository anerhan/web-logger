FactoryGirl.define do
  factory :user, aliases: [:owner, :manager] do
    first_name 'Dmitriy'
    last_name 'Bielorusov'
    email 'user@gmail.com'
    password "password"
    password_confirmation { |u| u.password }
  end
end
