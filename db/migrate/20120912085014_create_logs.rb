class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :interface_id
      t.text :logs

      t.timestamps
    end
  end
end
