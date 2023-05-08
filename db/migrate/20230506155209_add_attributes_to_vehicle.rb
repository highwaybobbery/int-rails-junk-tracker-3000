class AddAttributesToVehicle < ActiveRecord::Migration[6.1]
  def change
    add_column :vehicles, :type, :string, limit: 30, null: false
    add_column :vehicles, :mileage, :integer, null: false
    add_column :vehicles, :registration_id, :string, limit: 30, default: nil
    add_column :vehicles, :ad_id, :string, limit: 30, default: nil
  end
end
