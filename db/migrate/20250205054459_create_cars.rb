class CreateCars < ActiveRecord::Migration[7.2]
  def change
    create_table :cars do |t|
      t.text :company_car
      t.text :private_car
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
