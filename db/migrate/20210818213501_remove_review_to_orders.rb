class RemoveReviewToOrders < ActiveRecord::Migration[6.0]
  def change
    remove_reference :orders, :review, foreign_key: true, index: false
  end
end
