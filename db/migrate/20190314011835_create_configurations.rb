class CreateConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table :configurations do |t|
      t.string :script_dir
      t.string :memory_limit
      t.string :benchmark_dir

      t.timestamps
    end
  end
end
