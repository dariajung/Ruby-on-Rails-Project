class Suggestion < ActiveRecord::Base

	belongs_to :event
	belongs_to :cd
	
end