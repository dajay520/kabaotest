class AddInterfaceIdToConditionParams < ActiveRecord::Migration
  def change
    add_column :condition_params, :interface_id, :integer
  end
end
