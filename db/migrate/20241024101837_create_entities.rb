class CreateEntities < ActiveRecord::Migration[7.2]
  def change
    create_table :entities do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
