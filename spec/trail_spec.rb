require_relative 'spec_helper'

describe Trail do

  context "#new" do
    let(:trail){Trail.new("West Glacier Trail", "10/11/12", "1", "5 mi", "1", "1", "GSMNP", "TN", "This is a note")}
    it "should create a new trail entry" do
      trail.date.should == "10/11/12"
    end
  end

  context "#create" do
    let(:result){ Environment.database_connection.execute("SELECT * FROM trails") }
    let(:trail){ Trail.create("foo", "10/11/12", "1", "5 mi", "1", "1", "GSMNP", "TN", "This is a note") }
    context "with a valid trail name" do
      before do
        Trail.any_instance.stub(:valid?){ true }
        trail
      end
      it "should record the new id" do
        result[0]["id"].should == trail.id
      end
      it "should only save one row to the database" do
        result.count.should == 1
      end
      it "should actually save it to the database" do
        result[0].should == "foo"
      end
    end
    context "with an invalid trail name" do
      before do
        Trail.any_instance.stub(:valid?){ false }
        trail
      end
      it "should not save a new trail" do
        pending
        result.count.should == 0
      end
    end
  end

  context "#save" do
    let(:result){Environment.database_connection.execute("SELECT name FROM trails")}
    context "with a correct name" do
      let(:trail){Trail.new("South Mac Trail")}
      it "should return true" do
        pending
        trail.save.should be_true
      end
      it "should only save one row to the db" do
        pending
        trail.save
        result.count.should == 1
      end
      it "should confirm the save" do
        pending
        trail.save
        result[0]["name"].should == "South Mac Trail"
      end
    end

    context "with symbols in name" do
      let(:trail){Trail.new("Mart Fields!!")}
      it "should not save name" do
        pending
        trail.save.should be_false
      end
    end
  end

end
