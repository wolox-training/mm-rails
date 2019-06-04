require 'administrate/base_dashboard'

class BookDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    rents: Field::HasMany,
    id: Field::Number,
    genre: Field::String,
    author: Field::String,
    image: Field::String,
    title: Field::String.with_options(searchable: true),
    publisher: Field::String,
    year: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    title
    author
    genre
    year
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    rents
    id
    genre
    author
    image
    title
    publisher
    year
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    rents
    genre
    author
    image
    title
    publisher
    year
  ].freeze
end
