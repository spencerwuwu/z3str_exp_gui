class CreateBenchmarkTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :benchmark_types do |t|
      t.string :name
      t.string :ip

      t.timestamps
    end
    add_column :benchmark_names, :benchmark_type_id, :integer
  end
end
