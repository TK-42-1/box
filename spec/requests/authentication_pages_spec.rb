require 'spec_helper'

describe "Authentication" do
  subject { page }
  
  describe "signin page" do
    before {visit signin_path}
    
    it { should have_link('Sign in')}
    it { should have_title('Sign in')}
  end
  
  describe "signin" do
    before {visit signin_path}
    
    describe "with bad info" do
      before {click_button "Sign in" }
      it { should have_title('Sign in')}
      it { should have_selector('div.alert.alert-error')}
      
      describe "after visiting another page" do
        before { click_link "Home" }
        it {should_not have_selector('div.alert.alert-error')}
      end
    end
      
    describe "with good info" do
      describe "as admin" do
        let(:admin) { FactoryGirl.create(:admin)}
        before {sign_in admin}
        
        it {should have_title(admin.name)}
        it {should have_link('Index', href: users_path)}
        it {should have_link('Create', href: signup_path)}
        it {should have_link('Index', href: boxes_path)}
        it {should have_link('Create', href: new_box_path)}
        it {should have_link('Index', href: companies_path)}
        it {should have_link('Create', href: new_company_path)}
        it {should have_link('Settings', href: edit_user_path(admin))}
        it {should have_link('Sign out', href: signout_path)}
        it {should_not have_link('Sign in', href: signin_path)}
        
      end
      describe "as regular user" do
        let(:user) { FactoryGirl.create(:user)}
        before { sign_in user }
      
        it {should have_title(user.name)}
        it {should_not have_link('Users', href: users_path)}
        it {should have_link('Home', href: user_path(user))}
        it {should_not have_link('Settings', href: edit_user_path(user))}
        it {should have_link('Sign out', href: signout_path)}
        it {should_not have_link('Sign in', href: signin_path)}
      end
         
      describe "after signout" do
        let(:user) { FactoryGirl.create(:user)}
        before do
          sign_in user
          click_link "Sign out" 
        end
        it { should have_link('Sign in')}
      end
    end
  end
  
  describe "authorization" do
    
    describe "for non-signed in users" do
      let(:user) {FactoryGirl.create(:user)}
      
      describe "when attempting to visit protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Username", with: user.username
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
        
        describe "after signing in" do
          it "should render the desired page" do
            expect(page).to have_title('Box Tracking')
          end
        end
      end
      
      describe "in users controller" do
        
        describe "edit page" do
          before { visit edit_user_path(user)}
          it { should have_title('Sign in')}
        end
        
        describe "attempting to update" do
          before { patch user_path(user)}
          specify { expect(response).to redirect_to(signin_path)}
        end
        
        describe "visiting the index" do
          before { visit users_path }
          it { should have_title('Sign in')}
        end
      end
    end
    
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user)}
      let(:wrong_user) { FactoryGirl.create(:user, username: "wrong", email: "wrong@wrong.com")}
      let(:admin) { FactoryGirl.create(:admin, username: "admin")}
      

      describe "and as normal user" do
        before { sign_in user, no_capybara: true }
        
        describe "submitting GET to Users#edit" do
          before {get edit_user_path(wrong_user)}
          specify { expect(response.body).not_to match(full_title('Edit user'))}
          specify { expect(response).to redirect_to(root_url)}
        end
      
        describe "submitting PATCH to Users#update" do
          before { patch user_path(wrong_user)}
          specify { expect(response).to redirect_to(root_url)}
        end  
      end

      describe "and as admin" do
        before { sign_in admin, no_capybara:true }
        
        describe "submit GET to Users#edit" do
          before {get edit_user_path(wrong_user)}
          specify { expect(response.body).to match(full_title('Edit user'))}
          specify { expect(response.body).not_to redirect_to(root_url)}
        end
      end
    end
    
    describe "as non-admin" do
      let(:user) { FactoryGirl.create(:user)}
      let(:non_admin) { FactoryGirl.create(:user)}
      
      before { sign_in non_admin, no_capybara: true }
      
      describe "trying to send DELETE to Users#destroy" do
        before { delete user_path(user)}        
        specify { expect(response).to redirect_to(root_url)}
      end
    end
  end
end
