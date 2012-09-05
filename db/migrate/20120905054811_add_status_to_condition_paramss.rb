class AddStatusToConditionParamss < ActiveRecord::Migration
  def change
    add_column :condition_params, :status, :string
  end
end
