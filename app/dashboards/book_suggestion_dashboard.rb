require 'administrate/base_dashboard'

class BookSuggestionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    id: Field::Number,
    synopsis: Field::String,
    price: Field::Number.with_options(decimals: 2),
    author: Field::String,
    title: Field::String,
    link: Field::String,
    publisher: Field::String,
    year: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    user
    id
    synopsis
    price
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    user
    id
    synopsis
    price
    author
    title
    link
    publisher
    year
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    user
    synopsis
    price
    author
    title
    link
    publisher
    year
  ].freeze

  # Overwrite this method to customize how book suggestions are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(book_suggestion)
  #   "BookSuggestion ##{book_suggestion.id}"
  # end
end
