class CreateAnimalItems < ActiveRecord::Migration
  def change
    create_table :animal_items do |t|
      t.references :animal, index: true
      t.belongs_to :checkout, index: true

      t.timestamps
    end
  end
end
