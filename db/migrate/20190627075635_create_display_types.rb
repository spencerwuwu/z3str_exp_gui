class CreateDisplayTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :display_types do |t|
      t.string :name

      t.timestamps
    end
    add_column :benchmark_types, :display_type_id, :integer
  end
end
