class CreateInterfaces < ActiveRecord::Migration
  def change
    create_table :interfaces do |t|
      t.string :name_cn
      t.string :name_en
      t.string :remark
      t.string :type

      t.timestamps
    end
  end
end
