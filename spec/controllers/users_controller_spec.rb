require 'spec_helper'

describe UsersController do
render_views	

  describe "GET 'index" do
    
    describe "for non signed in user" do
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
      end
      
    end

    describe "for signed in user" do
      before(:each) do
        @user =  test_sign_in(Factory(:user))
        Factory(:user, :email => "korven@gmail.com")
        Factory(:user, :email => "korven@gmail.net")
      end

      it "should be successful " do
        get :index
        response.should be_success
      end
      
      it "should have the right title" do
        get :index
        response.should have_selector('title', :content => "All users")
        
      end

      it "should have an element for each user" do
        get :index
        User.all.each do |user|
          response.should have_selector('li', :content => user.name )
        end
        
      end
      
    end

  end
 
  
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

  describe "authenication for edit and update user" do
    before(:each) do
      @user = Factory(:user)
    end
    it "should denie access to user edit" do
      get :edit, :id => @user
      response.should redirect_to(signin_path)
    end
    it "should denie access to update" do
      put :update, :id => @user, :user => {}
      response.should redirect_to(signin_path)
    end
  end

  describe "admin attr" do
    before(:each) do
      @user = User.create!(@attr)
      end
    end
    it "should respnd to admin" do
      @user.should respond_to(:admin )
    end
    it "should not be admin by default" do
      @user.should_not be_admin
    end
    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end

end
