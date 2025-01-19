class CreateSchedules < ActiveRecord::Migration[8.0]
  def change
    create_table :schedules do |t|
      t.json :serialized_schedule, null: false, default: {}

      t.belongs_to :schedulable, polymorphic: true, null: false
      t.timestamps
    end
  end
end
