class CreateTestResults < ActiveRecord::Migration[5.2]
  def change
    create_table :test_results do |t|
      t.string :date
      t.integer :sat
      t.integer :unsat
      t.integer :timeout
      t.integer :misc
      t.string :commit
      t.integer :tool_id

      t.timestamps
    end
  end
end
