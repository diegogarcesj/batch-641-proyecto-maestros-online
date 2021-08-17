class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.text :description
      t.integer :status
      t.date :date
      t.references :user, null: false, foreign_key: true
      t.references :master, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true

      t.timestamps
    end
  end
end
