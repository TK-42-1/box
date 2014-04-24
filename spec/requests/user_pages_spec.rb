require 'spec_helper'

describe "User Pages" do
  subject { page }
  
  describe "index" do
    
    describe "as admin" do
      let(:user) { FactoryGirl.create(:admin)}
      before(:each) do
        sign_in user
        visit users_path
      end
      
      it { should have_title('All users')}
      it { should have_content('All users')}
    
      describe "pagination" do
      
        before(:all) {30.times { FactoryGirl.create(:user)}}      
        after(:all)  { User.delete_all}
      
        it {should have_selector('div.pagination')}
        it "should list each user" do
          User.paginate(page: 1).each do |user|
            expect(page).to have_selector('li', text: user.username)
          end
        end
      end
    
      describe "deletion link" do
        it { should_not have_link('delete')}
      
        describe "as admin" do
          let(:admin) { FactoryGirl.create(:admin)}
          before do
            sign_in admin
            visit users_path
          end
        
          it { should have_link('edit', edit_user_path(User.first))}
          it { should have_link('delete', href: user_path(User.first))}
          it "should be able to delete the user" do
            expect do
              click_link('delete', match: :first)
            end.to change(User, :count).by(-1)
          end
          it { should_not have_link('delete', href: user_path(admin))}
        end 
      end
    end
    
    describe "as regular" do
      let(:user) { FactoryGirl.create(:user)}
      before do
        sign_in user
        visit users_path
      end
     
      it { should_not have_title('All users')}
      it { should have_selector('div.alert.alert-error')}
      it { should have_content(user.name)}
    end
  end
  
  describe "create user page" do
    describe "as admin" do
      let(:admin) {FactoryGirl.create(:admin)}
      let(:submit) { "Save"}
      before do
        sign_in admin
        visit signup_path
      end    
    
      it { should have_content('Create user')}
      it { should have_title("Create user")}
      it { should have_content('Name')}
    end
    
    describe "as regular user" do
      let(:user) { FactoryGirl.create(:user)}
      before do
        sign_in user
        visit signup_path
      end
     
      it { should_not have_title('Create user')}
      it { should have_selector('div.alert.alert-error')}
      it { should have_content(user.name)}
    end
  end
  
  describe "profile page" do
    let(:user) {FactoryGirl.create(:user)}
    before { visit user_path(user) }
    
    it {should have_content(user.name)}
    it {should have_title(user.name)}
    
  end
  
  describe "create user" do
    let(:admin) {FactoryGirl.create(:admin)}
    let(:submit) { "Save"}
    before do
      sign_in admin
      visit signup_path
    end
    
    describe "with bad info" do
      it "should not make a user" do
        expect { click_button submit}.not_to change(User, :count)
      end
    end
    
    describe "with good info" do
      before do
        fill_in "Username", with: "Example"
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
  
  describe "edit page" do
    describe "as admin" do
      let(:admin) {FactoryGirl.create(:admin)}
      before do
        sign_in admin
        visit edit_user_path(admin)
      end
    
      describe "page" do
        it { should have_content("Edit user profile")}
        it { should have_title("Edit user")}
        it { should have_content('Admin')}
      end
    
      describe "with bad info" do
        before do 
          fill_in "Email", with: "bad@email.0."
          click_button "Save"
        end
      
        it { should have_content('error')}
      end
    
      describe "with good info" do
        let(:new_name) { "new name"}
        let(:new_username) { "newusername"}
        let(:new_email) { "new@email.com"}
        before do
          fill_in "Name", with: new_name
          fill_in "Username", with: new_username
          fill_in "Email", with: new_email
          check   "Admin"
          click_button "Save"
        end
      
        it {should have_title(new_name)}
        it {should have_selector('div.alert.alert-success')}
        it {should have_link('Sign out', href: signout_path)}
        specify { expect(admin.reload.name).to eq new_name }
        specify { expect(admin.reload.username).to eq new_username }
        specify { expect(admin.reload.email).to eq new_email }
        specify { expect(admin.reload.admin).to be_true}
      end
    
      describe "admin page" do
        let(:admin) {FactoryGirl.create(:admin)}
        before do
          sign_in admin
          visit edit_user_path(admin)
        end
      end
    end
    
    describe "as regular user" do
      describe "viewing own page" do
        let(:user) { FactoryGirl.create(:user)}
        before do
          sign_in user
          visit edit_user_path(user)
        end
        
        it { should_not have_title('Edit user')}
        it { should have_selector('div.alert.alert-error')}
        it { should have_content(user.name)}
      end
      
      describe "viewing others page" do
        let(:user) { FactoryGirl.create(:user)}
        let(:wrong) { FactoryGirl.create(:user, username: "wrong")}
        before do
          sign_in user
          visit edit_user_path(wrong)
        end
        
        it { should_not have_title('Edit user')}
      end
    end
  end
end
