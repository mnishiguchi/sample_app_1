class AddIndexToUserEmail < ActiveRecord::Migration
  def change
    # Enforce uniqueness by adding unique: true
    add_index :users, :email, unique: true
  end
end
