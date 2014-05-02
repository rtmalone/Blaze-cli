require_relative 'spec_helper'

describe Trail do

  context "#new" do
    let(:trail){Trail.new("West Glacier Trail")}
    it "should create a new trail entry" do
      trail.name.should == "West Glacier Trail"
    end
  end

  context "#save" do
    let(:result){Environment.database_connection.execute("SELECT name FROM trails")}
    context "with a correct name" do
      let(:trail){Trail.new("South Mac Trail")}
      it "should return true" do
        trail.save.should be_true
      end
      it "should only save one row to the db" do
        trail.save
        result.count.should == 1
      end
      it "should confirm the save" do
        trail.save
        result[0]["name"].should == "South Mac Trail"
      end
    end

    context "with symbols in name" do
      let(:trail){Trail.new("Mart Fields!!")}
      it "should not save name" do
        trail.save.should be_false
      end
    end
  end

end
