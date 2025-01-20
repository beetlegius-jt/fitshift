class CreateActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :activities do |t|
      t.string :name, null: false
      t.integer :duration_minutes, null: false, default: 60
      t.integer :max_capacity, null: false, default: 15

      t.belongs_to :company, null: false, foreign_key: true
      t.timestamps
    end
  end
end
