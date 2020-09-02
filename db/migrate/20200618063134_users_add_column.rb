class UsersAddColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :postal_code, :integer
    add_column :users, :prefectures, :string
    add_column :users, :city, :string
    add_column :users, :street, :string
    add_column :users, :building, :string
    add_column  :users,  :confirmation_token,  :string
    add_column  :users,  :confirmed_at,        :datetime
    add_column  :users,  :confirmation_sent_at,:datetime
    add_column  :users,  :unconfirmed_email,   :string
  end
end
