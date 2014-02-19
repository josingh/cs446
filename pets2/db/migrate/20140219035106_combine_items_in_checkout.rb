class CombineItemsInCheckout < ActiveRecord::Migration
  def up
  	Checkout.all.each do |checkout|
  		sums = checkout.animal_items.group(:animal_id).sum(:quantity)

  		sums.each do |animal_id, quantity|

  		end
  	end
  end

  def down
  	AnimalItem.destroy
  end
end
