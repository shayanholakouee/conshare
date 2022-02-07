require 'faker'
100.times do
  article = Article.new(title: Faker::Game.title,description:Faker::Quotes::Shakespeare.king_richard_iii_quote)
  article.save
end