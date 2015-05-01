class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :microposts, :users

    # Multiple key index (Active Record uses both keys at the same time.)
    # To retrieve all the microposts associated with a given user id
    # in reverse order of creation.
    add_index :microposts, [:user_id, :created_at]
  end
end
