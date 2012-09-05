require 'spec_helper'

describe UsersController do
render_views	

 
  
  describe "GET 'show'" do

     before(:each) do
      @user = Factory(:user)
    end
    
    it "returns http success" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector('title', :content => @user.name)
    end

    it "should have a h1" do
      get :show, :id => @user
      response.should have_selector('h1', :content => @user.name)
    end

    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector('h1>img', :class => "gravatar")
    end

  end

  describe "success" do
    
    before(:each) do
      @attr = {:name => "New User", :email => "new@user.com", :password => "foobar", :password_confirmation => "foobar"}
    end
    
    it "should create a user" do
      lambda do
        post :create, :user => @attr
      end.should change(User, :count).by(1)
    end

    it "should redirect to user show page" do
      post :create, :user => @attr
      response.should redirect_to(user_path(assigns(:user))) 
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
  end

  it "should heave the right title" do
  	get :new
  	response.should have_selector('title', :content => "Sign up")
  end

end
