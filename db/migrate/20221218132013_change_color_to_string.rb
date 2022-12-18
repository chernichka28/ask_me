class ChangeColorToString < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :color, :string
  end
end
