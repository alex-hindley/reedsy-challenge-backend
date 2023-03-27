class CreateMerchItems < ActiveRecord::Migration[7.0]
  def change
    create_table :merch_items do |t|
      t.string :code
      t.string :name
      t.float :price
      t.timestamps
    end
  end
end
