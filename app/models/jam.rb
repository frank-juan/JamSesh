class Jam < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	belongs_to :genre
	belongs_to :jam_skill
end
