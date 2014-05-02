require_relative 'spec_helper'

describe "Creating a new trail entry" do

  context "adding a name" do
    let!(:output){ blaze_with_input("1", "North Face")}
    it "should insert name of trail" do
      Trail.count.should == 1
    end
    it "should print confirmation" do
      output.should include("North Face has been added")
      Trail.count.should == 1
    end
  end

  context "adding an invalid name with symbols" do
    let(:output){blaze_with_input("1", "Mart Fields!!")}
    it "should not save the trail name" do
      Trail.count.should == 1
    end
    it "should print an error msg" do
      output.should include("'Mart Fields!!' is not valid; symbols or special characters are not allowed")
    end
    it "should allow for input again" do
      menu_text = "What is the trail name?"
      output.should include(menu_text, "not valid", menu_text)
    end
  end

end
