class CreateVolumeDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :volume_discounts do |t|
      t.integer :merch_item_id
      t.integer :min_volume
      t.integer :max_volume
      t.float :percentage

      t.timestamps
    end
  end
end
