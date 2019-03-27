class CreateDaysToRuns < ActiveRecord::Migration[5.2]
  def change
    create_table :days_to_runs do |t|
      t.integer :benchmark_type_id
      t.integer :tool_id
      t.integer :days

      t.timestamps
    end
  end
end
