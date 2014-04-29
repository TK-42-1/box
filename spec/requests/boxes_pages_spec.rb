require 'spec_helper'

describe "BoxPages" do
  subject { page }
  
  describe "index" do
    describe "as admin" do
      let(:user) { FactoryGirl.create(:admin)}
      before(:each) do
        sign_in user
        visit boxes_path
      end
      
      it { should have_title('All boxes')}
      it { should have_content('All boxes')}
    end
    
    describe "pagination" do
    
      before(:all) {30.times { FactoryGirl.create(:box)}}      
      after(:all)  { Box.delete_all}
    
      it {should have_selector('div.pagination')}
      it "should list each box" do
        Box.paginate(page: 1).each do |box|
          expect(page).to have_selector('li', text: box.company)
        end
      end
    end
  end
  
  describe "create box page" do
    describe "as admin" do
      let(:admin) {FactoryGirl.create(:admin)}
      let(:submit) { "Save"}
      before do
        sign_in admin
        visit new_box_path
      end    
    
      it { should have_content('Create box')}
      it { should have_title("Create box")}
      it { should have_content('Company')}
      it { should have_content('Department')}
      it { should have_content('Description of contents')}
      it { should have_content('Month')}
      it { should have_content('Year')}
      it { should have_content('Destroy by')}
    end
  end
end
