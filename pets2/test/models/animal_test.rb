require 'test_helper'

class AnimalTest < ActiveSupport::TestCase
test "animal attributes must not be empty" do
	animal = Animal.new
	assert animal.invalid?
	assert animal.errors[:name].any?
	assert animal.errors[:description].any?
	assert animal.errors[:age].any?
	assert animal.errors[:image_url].any?
	assert animal.errors[:breed].any?
end

def new_animal(image_url)
	Animal.new(name: "test",
		description: "yyy",
		age: 4,
		image_url: image_url,
		breed: "Cat")
end
test "image url" do
	ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
		http://a.b.c/x/y/z/fred.gif }
	bad = %w{ fred.doc fred.gif/more fred.gif.more }
	ok.each do |name|
		assert new_animal(name).valid?, "#{name} should be valid"
	end
	bad.each do |name|
		assert new_animal(name).invalid?, "#{name} shouldn't be valid"
	end
end
end
