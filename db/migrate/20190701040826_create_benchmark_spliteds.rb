class CreateBenchmarkSpliteds < ActiveRecord::Migration[5.2]
  def change
    create_table :benchmark_spliteds do |t|
      t.string :name
      t.integer :display_type_id

      t.timestamps
    end
    add_column :benchmark_names, :benchmark_splited_id, :integer
  end
end
