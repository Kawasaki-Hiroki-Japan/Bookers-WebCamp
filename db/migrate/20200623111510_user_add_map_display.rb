class UserAddMapDisplay < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_display_map, :boolean, default: false, null: false
  end
end
