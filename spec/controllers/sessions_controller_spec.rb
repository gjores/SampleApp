require 'spec_helper'

describe SessionsController do
	render_views
  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
  	
  	it "should heave the right title" do
  		get :new
  		response.should have_selector('title', :content => "Sign in")
  	end

  end
  describe "POST 'create'" do
    describe "POST failed" do
      
      before(:each) do
        
        @attr = { :email => "", :password => ""}
      end
      
      it "should re-render new page" do
        post :create, :session => @attr
        
      end
      it "should have a error flash" do
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end
    end

    describe "POST success" do

       before(:each) do
        @user = Factory(:user)
        @attr = { :email => @user.email, :password => @user.password}
      end
      it "should sign in the user" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in        
      end
      
      it "should redirect to the user show page" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
        
      end
    end
    
  end

end
