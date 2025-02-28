class CreateAlcoholLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :alcohol_logs do |t|
      t.datetime :check_time, null: false
      t.integer :confirmation, null: false
      t.boolean :detector_used, null: false, default: true
      t.float :result, null: false
      t.boolean :condition, null: false, default: false
      t.text :log_remarks
      t.references :user, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true
      t.integer :driving_status, null: false

      t.timestamps
    end
  end
end
