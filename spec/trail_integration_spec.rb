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

  context "adding an invalid name" do
  end


end
