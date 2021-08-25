class AddHoursToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :hours, :integer
  end
end
