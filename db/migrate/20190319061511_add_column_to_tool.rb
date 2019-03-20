class AddColumnToTool < ActiveRecord::Migration[5.2]
  def change
    add_column :tools, :lastest_commit, :string
    add_column :tools, :lastest_date, :date
    add_column :tools, :days_to_run, :integer
    add_column :tools, :repo_url, :string
    add_column :tools, :branch_name, :string
    add_column :tools, :build_everytime, :boolean
  end
end
