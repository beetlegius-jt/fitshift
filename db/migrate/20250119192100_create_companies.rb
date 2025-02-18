class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.integer :utc_offset, null: false
      t.string :subdomain, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
