class Checkout < ActiveRecord::Base
	has_many :animal_items, dependent: :destroy
	def add_animal(animal_id)
		current_item = animal_items.find_by(animal_id: animal_id)
		if current_item
			current_item.quantity = 1
		else
			current_item = animal_items.build(animal_id: animal_id)
		end
		current_item
	end
end
