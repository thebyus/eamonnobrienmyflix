Fabricator(:category) do
  cat { Faker::Lorem.words(1).join("")}
end
