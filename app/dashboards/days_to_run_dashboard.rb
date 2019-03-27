require "administrate/base_dashboard"

class DaysToRunDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    benchmark_type: Field::BelongsTo,
    tool: Field::BelongsTo,
    id: Field::Number,
    days: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :benchmark_type,
    :tool,
    :id,
    :days,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :benchmark_type,
    :tool,
    :id,
    :days,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :benchmark_type,
    :tool,
    :days,
  ].freeze

  # Overwrite this method to customize how days to runs are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(days_to_run)
  #   "DaysToRun ##{days_to_run.id}"
  # end
end
