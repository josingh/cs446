class AddQuantitToAnimalItems < ActiveRecord::Migration
  def change
    add_column :animal_items, :quantity, :integer, default: 1
  end
end
