class AddColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hp, :integer, default: 100
  end
end
