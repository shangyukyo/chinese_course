class Student < ApplicationRecord
	has_many :lessons
	store :extras, accessors: [:nickname, :sex, :head_img]
end
