require 'spec_helper'

describe Location do
  before do
    @location = Location.new(code: '12345', room: '1', row: '2', section: '3', shelf: '4', slot: '5')
  end
  
  subject { @location }
  
  it { should respond_to(:code)}
  it { should respond_to(:room)}
  it { should respond_to(:row)}
  it { should respond_to(:section)}
  it { should respond_to(:shelf)}
  it { should respond_to(:slot)}
  
  it { should be_valid }
  
  describe "when code is incomplete" do
    before { @location.code = '1111' }    
    it { should_not be_valid } 
  end
  
  describe "when room is empty" do
    before { @location.room = ''}    
    it { should_not be_valid}
  end
  
  describe "when row is empty" do
    before { @location.row = ''}    
    it { should_not be_valid}
  end
  
  describe "when section is empty" do
    before { @location.section = ''}    
    it { should_not be_valid}
  end
  
  describe "when shelf is empty" do
    before { @location.shelf = ''}    
    it { should_not be_valid}
  end
  
  describe "when slot is empty" do
    before { @location.slot = ''}    
    it { should_not be_valid}
  end
end
