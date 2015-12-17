class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.integer :user_id
      t.float :price
      t.integer :qty,default: 1

      t.timestamps null: false
    end
  end
end
