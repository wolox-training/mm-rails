require 'administrate/base_dashboard'

class UserDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    rents: Field::HasMany,
    book_suggestions: Field::HasMany,
    id: Field::Number,
    provider: Field::String,
    uid: Field::String,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    allow_password_change: Field::Boolean,
    remember_created_at: Field::DateTime,
    confirmation_token: Field::String,
    confirmed_at: Field::DateTime,
    confirmation_sent_at: Field::DateTime,
    unconfirmed_email: Field::String,
    first_name: Field::String.with_options(searchable: true),
    last_name: Field::String.with_options(searchable: true),
    email: Field::String.with_options(searchable: true),
    tokens: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    locale: Field::String,
    sign_in_count: Field::Number,
    current_sign_in_at: Field::DateTime,
    last_sign_in_at: Field::DateTime,
    current_sign_in_ip: Field::String,
    last_sign_in_ip: Field::String
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    first_name
    last_name
    email
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    rents
    book_suggestions
    id
    provider
    uid
    encrypted_password
    reset_password_token
    reset_password_sent_at
    allow_password_change
    remember_created_at
    confirmation_token
    confirmed_at
    confirmation_sent_at
    unconfirmed_email
    first_name
    last_name
    email
    tokens
    created_at
    updated_at
    locale
    sign_in_count
    current_sign_in_at
    last_sign_in_at
    current_sign_in_ip
    last_sign_in_ip
  ].freeze

  FORM_ATTRIBUTES = %i[
    first_name
    last_name
    email
    locale
  ].freeze
end
