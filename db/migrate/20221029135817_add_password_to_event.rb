class AddPasswordToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :password, :text
  end
end
