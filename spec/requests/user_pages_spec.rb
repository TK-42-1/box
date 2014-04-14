require 'spec_helper'

describe "User Pages" do
  subject { page }
  
  describe "signup page" do
    before { visit signup_path }    
    
    it { should have_content('Sign up')}
    it { should have_title("Sign up")}
    
  end
  
  describe "profile page" do
    let(:user) {FactoryGirl.create(:user)}
    before { visit user_path(user) }
    
    it {should have_content(user.name)}
    it {should have_title(user.name)}
  end
  
  describe "sign up" do
    before {visit signup_path}
    
    let(:submit) { "Create User"}
    
    describe "with bad info" do
      it "should not make a user" do
        expect { click_button submit}.not_to change(User, :count)
      end
    end
    
    describe "with good info" do
      before do
        fill_in "Name", with: "Example"
        fill_in "Email", with: "dude@example.com"
        fill_in "Password", with: "farts"
        fill_in "Confirmation", with: "farts"
      end
      
      it "should create a user" do
        expect { click_button submit}.to change(User, :count).by(1)
      end
    end
  end
end
