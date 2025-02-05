class CreatePaidLeaves < ActiveRecord::Migration[7.2]
  def change
    create_table :paid_leaves do |t|
      t.date :joining_date, null: false
      t.date :base_date, null: false
      t.boolean :part_time, null: false, default: false
      t.integer :classification
      t.references :user, null: false, foreign_key: true
      t.text :paid_remarks

      t.timestamps
    end
  end
end
