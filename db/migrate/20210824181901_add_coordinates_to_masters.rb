class AddCoordinatesToMasters < ActiveRecord::Migration[6.0]
  def change
    add_column :masters, :latitude, :float
    add_column :masters, :longitude, :float
  end
end
