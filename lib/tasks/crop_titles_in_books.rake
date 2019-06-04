namespace :crop_titles_in_books do
  desc 'Crops books titles with more than 25 characters'
  task create: :environment do
    Book.where('length(title) > 25').find_each do |book|
      book.update title: book.title.first(22) + '...'
    end
  end
end
