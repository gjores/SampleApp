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

    it "should sign the user in" do
      post :create, :user => @attr
      controller.should be_signed_in
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

  describe "GET 'edit" do
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => @user
      response.should have_selector('title', :content => "Edit user")
    end

    it "should hava a link to gravatar" do
      get :edit, :id => @user
      response.should have_selector('a', :href => 'http://gravatar.com/emails',
                                         :content => "change")
    end
  end

  describe "PUT 'update" do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
    
    describe "failure" do
      before(:each) do
      @attr = {:name => "", :email => "", :password => "", :password_confirmation => ""}
    end
      it "should rerender the same page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @user, :user => @attr      
        response.should have_selector('title', :content => "Edit user")
      end
      
    end

    describe "success" do
      before(:each) do
        @attr = {  :name => "Shithead", :email => "shit@head.com", 
                   :password => 'foobar123', :password_confirmation => "foobar123"  }
      end
    end
        it "should change the user attr" do
          put :update, :id => @user, :user => @attr
          user = assigns(:user)
          @user.reload
          @user.name.should == user.name
          @user.email.should == user.email
          @user.encrypted_password.should == user.encrypted_password
        end

        it "should hava flash message" do
          put :update, :id => @user, :user => @attr

          flash[:success => "Profile updated."]
          
        end
    
  end

end
