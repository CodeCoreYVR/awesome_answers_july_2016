QUESTIONS_TO_CREATE = 500

QUESTIONS_TO_CREATE.times do
    Question.create title:      Faker::StarWars.quote,
                    body:       Faker::Hipster.paragraph,
                    view_count: rand(100)
end

["Sports", "Tech", "News", "Cats", "Dogs"].each do |t|
  Tag.create name: t
end

10.times { Tag.create name: Faker::Superhero.name }

puts Cowsay.say "Created #{QUESTIONS_TO_CREATE} questions and 15 tags"
