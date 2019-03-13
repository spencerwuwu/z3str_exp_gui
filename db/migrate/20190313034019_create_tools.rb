class CreateTools < ActiveRecord::Migration[5.2]
  def change
    create_table :tools do |t|
      t.string :name
      t.integer :test_cycle

      t.timestamps
    end
  end
end
