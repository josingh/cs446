class AnimalItem < ActiveRecord::Base
  belongs_to :animal
  belongs_to :checkout
end
