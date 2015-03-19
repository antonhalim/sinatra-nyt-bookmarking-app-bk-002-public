articles = JSON.parse(File.read("db/articles.json"))
articles["results"].each_with_index do |article|
  Article.create(article)
end
