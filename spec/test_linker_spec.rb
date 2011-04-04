require 'spec_helper'

describe TestLinker do
  it "should have a VERSION constant" do
    TestLinker.const_get('VERSION').should_not be_empty
  end

  it "has logging turned off by default" do
    puts TestLinker.instance_variables
    TestLinker.log?.should be_false
  end
end
