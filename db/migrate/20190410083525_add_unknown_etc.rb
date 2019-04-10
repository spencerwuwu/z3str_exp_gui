class AddUnknownEtc < ActiveRecord::Migration[5.2]
  def change
    add_column :test_results, :unknown, :integer
    add_column :test_results, :exception, :integer
  end
end
