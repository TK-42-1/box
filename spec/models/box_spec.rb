require 'spec_helper'

describe Box do
  before do
    @box = Box.new( description: 'new box', user_id: '1', month: '07', year: '2014', destroy_by: '07-2021', company_id: '1', department_id: '1')
  end 
  
  subject { @box }
  
  it { should respond_to(:description)}
  it { should respond_to(:user_id)}
  it { should respond_to(:company_id)}
  it { should respond_to(:department_id)}
  it { should respond_to(:month)}
  it { should respond_to(:year)}
  it { should respond_to(:destroy_by)}
  it { should respond_to(:stored_by)}
  
  it { should be_valid }
  
  describe "when there is no description" do
    before { @box.description = " " }
    it { should_not be_valid }
  end
  
  describe "when there is no creator" do
    before { @box.user_id = " " }
    it { should_not be_valid }
  end
  
  describe "when there is no company" do
    before { @box.company_id = " " }
    it { should_not be_valid }
  end
  
  describe "when there is no department" do
    before { @box.department_id = " " }
    it { should_not be_valid }
  end
  
  describe "when there is no month" do
    before { @box.month = " " }
    it { should_not be_valid }
  end
  
  describe "when there is no year" do
    before { @box.year = " " }
    it { should_not be_valid }
  end
  
  describe "when there is no destroy date" do
    before { @box.destroy_by = " " }
    it { should_not be_valid }
  end
  
  describe "when there is no user associated" do
    before { @box.user_id = " " }
    it { should_not be_valid }
  end
end
