Fabricator(:user) do
  name     { sequence(:name) { |number| "User #{number}" } }
  email    { sequence(:name) { |number| "user#{number}@example.com" } }
  password 'changeme'
  password_confirmation 'changeme'
end
