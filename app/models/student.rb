class Student < ApplicationRecord
	has_many :lessons
	has_many :orders
	store :extras, accessors: [:nickname, :sex, :head_img]
end
