class AddBenchmarkToResults < ActiveRecord::Migration[5.2]
  def change
    add_column :test_results, :benchmark, :string
  end
end
