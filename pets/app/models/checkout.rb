class Checkout < ActiveRecord::Base
	has_many :animal_items, dependent: :destroy
end
