require "administrate/base_dashboard"

class ToolDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    test_results: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    test_cycle: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    command: Field::Text,
    repo_url: Field::String,
    branch_name: Field::String,
    build_everytime: Field::Boolean,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :name,
    :test_cycle,
    :branch_name,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :name,
    :test_cycle,
    :repo_url,
    :branch_name,
    :build_everytime,
    :test_results,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :test_cycle,
    :command,
    :repo_url,
    :branch_name,
    :build_everytime,
  ].freeze

  # Overwrite this method to customize how tools are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(tool)
  #   "Tool ##{tool.id}"
  # end
end
