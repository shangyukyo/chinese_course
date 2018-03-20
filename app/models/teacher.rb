class Teacher < ApplicationRecord
	has_many :lessons

	store :extras, accessors: [:lesson_size]
end
