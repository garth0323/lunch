
Fabricator(:restaurant) do
  name { Faker::Hipster.word }
  description  { Faker::Hipster.paragraph }
end