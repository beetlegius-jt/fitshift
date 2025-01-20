class CreateReservations < ActiveRecord::Migration[8.0]
  def change
    create_table :reservations do |t|
      t.timestamp :starts_at, null: false, precision: 0

      t.belongs_to :activity, null: false, foreign_key: true
      t.belongs_to :customer, null: false, foreign_key: true

      t.index [ :starts_at, :customer_id, :activity_id ], unique: true
      t.timestamps
    end
  end
end
