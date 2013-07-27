class AddKeyFieldsToUserAndRepo < ActiveRecord::Migration
  def up
    add_column :users, :login_key, :string
    add_index :users, :login_key, unique: true
    remove_index :users, :login

    add_column :repos, :name_key, :string
    add_index :repos, [:user_id, :name_key], unique: true
    remove_index :repos, [:user_id, :name]
  end

  def down
    remove_column :users, :login_key
    remove_index :users, :login_key
    add_index :users, :login, unique: true

    remove_column :repos, :name_key
    remove_index :repos, [:user_id, :name_key]
    add_index :repos, [:user_id, :name], unique: true
  end
end
