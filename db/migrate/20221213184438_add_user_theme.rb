class AddUserTheme < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :color, :text, default: "#e4e3e2"
  end
end
