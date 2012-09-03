require 'spec_helper'

describe UsersController do
render_views	

  before(:each) do
    @user = Factory(:user)
  end
  
  describe "GET 'show'" do
    it "returns http success" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
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
