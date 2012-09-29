class	MicropostsController < ApplicationController
	
	before_filter :authenticate 
	
	def create
		@user = current_user
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			redirect_to user_path(@user), :flash => {:success => "micropost created"}

		else
			render 'pages/home'
		end
	end

	def destroy
		
	end
end