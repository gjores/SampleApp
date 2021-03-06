class UsersController < ApplicationController
  
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  def index
    @users = User.paginate(:page => params[:page], :per_page => 15)
    @title = "All users"
  end

  def new
  	@title = 'Sign up'
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  	@microposts = @user.microposts.paginate(:page => params[:page], :per_page => 5)
    @title = @user.name
  end

  def create

  	@user = User.new(params[:user])
  		if @user.save
  		sign_in @user
      redirect_to user_path(@user), :flash => {:success => "Welcome to the app, man!"}
		  
    else
  			@title = "sign up"
  			render 'new'
  		end
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
    
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      #it worked
      redirect_to @user
      flash[:success] = "Profile updated."
    else
    @title = "Edit user"
    render 'edit'
  end
  end

  def destroy
    @user.destroy
    redirect_to users_path, :flash => { :success => "User destroyed"}
  end

  private 

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
      
    end

    def admin_user
      
      @user = User.find(params[:id])
      redirect_to(root_path) unless (current_user.admin? && !current_user?(user))
      
    end
    

end
