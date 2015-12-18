class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :image
      t.float :unitprice
      t.integer :stock
      t.integer :promotion,default: 0
      t.datetime :p_start
      t.datetime :p_end
      t.integer :status
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
