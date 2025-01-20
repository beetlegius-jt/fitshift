class AddRoleAndOwnerToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :integer, null: false, default: User.roles["customer"]
    add_belongs_to :users, :owner, polymorphic: true
  end
end
