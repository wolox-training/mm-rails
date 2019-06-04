require 'administrate/base_dashboard'

class RentDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    book: Field::BelongsTo,
    id: Field::Number,
    starting_date: Field::DateTime,
    ending_date: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    user
    book
    id
    starting_date
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    user
    book
    id
    starting_date
    ending_date
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    user
    book
    starting_date
    ending_date
  ].freeze
end
