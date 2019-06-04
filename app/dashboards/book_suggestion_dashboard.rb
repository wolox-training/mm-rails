require 'administrate/base_dashboard'

class BookSuggestionDashboard < Administrate::BaseDashboard
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

  COLLECTION_ATTRIBUTES = %i[
    user
    id
    synopsis
    price
  ].freeze

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
end
