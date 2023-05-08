class CreateSeats < ActiveRecord::Migration[6.1]
  def change
    create_table :seats do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.string :status, limit: 10, default: 'works', null: false

      t.timestamps
    end
  end
end
