Fabricator(:user) do
  email { Faker::Internet.email }
  password 'password'
  full_name { Faker::Name.name }
end

Fabricator(:invalid_user, from: :user) do
  password ''
end
