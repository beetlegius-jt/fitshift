class CreateAttendances < ActiveRecord::Migration[8.0]
  def change
    create_table :attendances do |t|
      t.timestamp :attended_at, null: false, precision: 0

      t.belongs_to :company, null: false, foreign_key: true
      t.belongs_to :customer, null: false, foreign_key: true

      t.index [ :attended_at, :company_id, :customer_id ], unique: true
      t.timestamps
    end
  end
end
