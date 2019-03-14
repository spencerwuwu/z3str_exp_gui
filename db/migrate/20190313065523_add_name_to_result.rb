class AddNameToResult < ActiveRecord::Migration[5.2]
  def change
    add_column :test_results, :name, :string
    add_column :tools, :command, :text
  end
end
