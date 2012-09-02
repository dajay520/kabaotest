class CreateConditionParams < ActiveRecord::Migration
  def change
    create_table :condition_params do |t|
      t.string :name
      t.string :in
      t.string :out
      t.string :remark

      t.timestamps
    end
  end
end
