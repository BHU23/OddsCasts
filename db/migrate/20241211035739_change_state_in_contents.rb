class ChangeStateInContents < ActiveRecord::Migration[8.0]
  def change
    change_column :contents, :state, :integer, using: 'state::integer'
    change_column_default :contents, :state, 0
  end
end
