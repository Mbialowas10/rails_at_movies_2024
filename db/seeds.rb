require 'csv'

Movie.delete_all
ProductionCompany.delete_all
Page.delete_all

#fetch the filename
filename = Rails.root.join("db/top_movies.csv")

puts "Loading Movies from the CSV file: #{filename}"

csv_data = File.read(filename)
movies = CSV.parse(csv_data, headers: true, encoding: "utf-8")

movies.each do |m|
  production_company = ProductionCompany.find_or_create_by(name: m["production_company"])
  if production_company && production_company.valid?
    # create a movie
    movie = production_company.movies.create(
      title:            m["original_title"],
      year:             m["year"],
      duration:         m["duration"],
      description:      m["description"],
      average_vote:     m["avg_vote"],
    )
    puts "Invalid movie #{m['original_title']}" unless movie&.valid?
  else
    puts "invalid producttion company #{m["production_company"]} for movie #{m["original_title"]}."
  end
  puts m["original_title"]
end

puts "Created #{ProductionCompany.count} Production companies"
puts "Created #{Movie.count} Movies..."

Page.create(
  title: 'About the data',
  context: 'The data powering this great website was supplied by Kaggle.',
  permalink: "about"
)
Page.create(
  title: 'Contact Us',
  context: 'If you like this site and want to chat, please reach out obviouslyFake@email.com',
  permalink: 'contact'
)