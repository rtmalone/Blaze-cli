require_relative 'spec_helper'

describe "Menu Integration" do
  let(:menu_text) do
<<-EOS
_-_ Welcome to Blaze-cli! _-_

Please choose a number:
  <1> Log a trail
  <2> View log
  <3> Search log
EOS
end
  context "the starting menu should display when app is run" do
    let(:shell_output){ blaze_with_input() }
    it "should print the menu" do
      shell_output.should include(menu_text)
    end
  end

  context "user selects option 1" do
    let(:shell_output){blaze_with_input("1")}
    it "should allow for user input" do
      shell_output.should include("What is the trail name?")
    end
  end

  context "user selects option 2" do
    let(:shell_output){ blaze_with_input("2") }
    it "should list your log" do
      shell_output.should include("Your Blaze-cli trail log:")
    end
  end

  context "user selects option 3" do
    let(:shell_output){ blaze_with_input ("3") }
    it "should print the next menu for searching" do
      shell_output.should include("Select what you'd like to search:")
    end
  end

  context "user selects option 10" do
    let(:shell_output){ blaze_with_input("10") }
    it "should raise error" do
      shell_output.should include("'10' is not valid. Please try again.")
    end
    it "should print the menu again" do
      shell_output.should include_in_order(menu_text, "10", menu_text)
    end
  end

  context "user returns without input" do
    let(:shell_output){ blaze_with_input("")}
    it "should raise error" do
      shell_output.should include "'' is not valid. Please try again."
    end
    it "should print the menu again" do
      shell_output.should include_in_order(menu_text, menu_text)
    end
  end

  context "user enters wrong input, menu should print again" do
    let(:shell_output){ blaze_with_input("8", "1") }
    it "should allow for a correct selection" do
      shell_output.should include("What is the trail name?")
    end
  end

  context "user enters wrong input multiple times" do
    let(:shell_output){ blaze_with_input("10", "8", "I'm incompentent on a keyboard", "2")}
    it "should continue printing menu until correct selection" do
      shell_output.should include("Your Blaze-cli trail log:")
    end
  end
  #end of test class
end
