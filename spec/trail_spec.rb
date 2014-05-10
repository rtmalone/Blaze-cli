require_relative 'spec_helper'

describe Trail do
  context ".all" do
    context "with no trails in the db" do
      it "should return an empty array" do
        Trail.all.should == []
      end
    end
    context "with multiple entries in the database" do
        let(:foo){ Trail.new("foo", "10/11/12", "1", "5 mi", "1", "1", "GSMNP", "TN", "This is a note") }
        let(:bar){ Trail.new("bar", "10/11/12", "1", "5 mi", "1", "1", "GSMNP", "NC", "This is a note") }
        let(:grille){ Trail.new("grille", "10/11/12", "1", "5 mi", "1", "1", "GSMNP", "GA", "This is a note") }
      before do
        foo.save
        bar.save
        grille.save
      end
      it "should return all the trail entries in the db" do
        trail_attrs = Trail.all.map{ |trail| [trail.name, trail.state, trail.id] }
        trail_attrs.should == [["foo", "TN", foo.id], ["bar", "NC", bar.id], ["grille", "GA", grille.id]]
      end
    end
  end

  context ".count" do
    context "with no trails in the db" do
      it "should return 0" do
        Trail.count.should == 0
      end
    end
    context "with multiple trails in the db" do
      before do
        Trail.new("foo", "10/11/12", "1", "5 mi", "1", "1", "GSMNP", "TN", "This is a note").save
        Trail.new("bar", "10/11/12", "1", "5 mi", "1", "1", "GSMNP", "TN", "This is a note").save
        Trail.new("grille", "10/11/12", "1", "5 mi", "1", "1", "GSMNP", "TN", "This is a note").save
      end
      it "should return the correct count" do
        Trail.count.should == 3
      end
    end
  end

  context ".last" do
    context "with no trails in the db" do
      it "should return nil" do
        Trail.last.should be_nil
      end
    end
    context "with multiple trails in the db" do
      let(:last_trail){ Trail.new("Blue Mussel", "10/11/12", "1", "5 mi", "1", "1", "GSMNP", "TN", "This is a note") }
      before do
        Trail.new("foo", "10/11/12", "1", "5 mi", "1", "1", "GSMNP", "TN", "This is a note").save
        Trail.new("bar", "10/11/12", "1", "5 mi", "1", "1", "GSMNP", "TN", "This is a note").save
        Trail.new("grille", "10/11/12", "1", "5 mi", "1", "1", "GSMNP", "TN", "This is a note").save
        last_trail.save
      end
      it "should return the last student inserted" do
        Trail.last.name.should == "Blue Mussel"
      end
      it "should return the last student inserted with the id populated" do
        Trail.last.id.should == last_trail.id
      end
    end
  end


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
        result[0]["name"].should == "foo"
      end
    end
    context "with an invalid trail name" do
      before do
        Trail.any_instance.stub(:valid?){ false }
        trail
      end
      it "should not save a new trail" do
        result.count.should == 0
      end
    end
  end

  context "#save" do
    let(:result){Environment.database_connection.execute("SELECT * FROM trails")}
    let(:trail){Trail.new("South Mac Trail", "10/11/12", "1", "5 mi", "1", "1", "GSMNP", "TN", "This is a note")}
    context "with a correct name" do
      it "should return true" do
        trail.save.should be_true
      end
      it "should only save one row to the db" do
        trail.save
        result.count.should == 1
      end
      it "should confirm the save" do
        trail.save
        result[0]["park"].should == "GSMNP"
      end
    end

    context "with symbols in name" do
      before do
        trail.stub(:valid?) { false }
      end
      it "should not save trail name to db" do
        trail.save
        result.count.should == 0
      end
    end
  end

  context "#valid?" do
    let(:result){ Environment.database_connection.execute("SELECT name FROM trails") }
    context "after fixing a name errors" do
      let(:trail){ Trail.new("555", "10/11/12", "1", "5 mi", "1", "1", "GSMNP", "TN", "This is a note") }
      it "should return true" do
        trail.valid?.should be_false
        trail.name = "Camping Cove"
        trail.valid?.should be_true
      end
    end
    context "with an invalid name" do
      let(:trail){ Trail.new("555", "10/11/12", "1", "5 mi", "1", "1", "GSMNP", "TN", "This is a note") }
      it "should return false" do
        trail.valid?.should be_false
      end
      it "should save the error messages" do
        trail.valid?
        trail.errors.first.should == "'555' is not a valid trail name, as it does not include any letters."
      end
    end
  end

end
