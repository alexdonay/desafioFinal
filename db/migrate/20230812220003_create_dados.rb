class CreateDados < ActiveRecord::Migration[7.0]
  def change
    create_table :dados do |t|
      t.string :purchaser_name
      t.string :item_description
      t.string :item_price
      t.string :purchase_count
      t.string :merchant_address
      t.string :merchant_name

      t.timestamps
    end
  end
end
