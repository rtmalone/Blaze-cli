require_relative 'spec_helper'

describe "Menu Integration" do
  context "the starting menu should display when app is run" do
    let(:shell_output){ blaze_with_input() }
    it "should print the menu" do
      shell_output.should include(menu_text)
    end
  end
end
