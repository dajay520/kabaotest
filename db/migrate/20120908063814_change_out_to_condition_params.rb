class ChangeOutToConditionParams < ActiveRecord::Migration
  def change
    change_column :condition_params, :in, :text
    change_column :condition_params, :out, :text
  end
end
