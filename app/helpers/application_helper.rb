module ApplicationHelper
	#Returns title per page basis
	def title
		base_title = "Sample app title"

		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
end
