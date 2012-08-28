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

	def logo
		image_tag("idea-logo.jpg", :class => "logo", :width => "200", :alt => "logo")
		
	end
end
