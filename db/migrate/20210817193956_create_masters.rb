class CreateMasters < ActiveRecord::Migration[6.0]
  def change
    create_table :masters do |t|
      t.text :description
      t.string :commercial_address
      t.string :schedule
      t.integer :price_per_hour
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
