class AddFosterParentToAnimalItem < ActiveRecord::Migration
  def change
    add_reference :animal_items, :foster_parent, index: true
  end
end
