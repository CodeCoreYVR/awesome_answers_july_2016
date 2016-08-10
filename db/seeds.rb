QUESTIONS_TO_CREATE = 500

QUESTIONS_TO_CREATE.times do
  Question.create title:      Faker::StarWars.quote,
                  body:       Faker::Hipster.paragraph,
                  view_count: rand(100)
end

puts Cowsay.say "Created #{QUESTIONS_TO_CREATE} questions"
