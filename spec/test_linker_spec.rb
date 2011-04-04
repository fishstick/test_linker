require 'spec_helper'

describe TestLinker do
  it "should have a VERSION constant" do
    TestLinker.const_get('VERSION').should_not be_empty
  end

  it "has logging turned off by default" do
    TestLinker.log?.should be_false
  end

  it "can change logging to on" do
    TestLinker.log = true
    TestLinker.log?.should == true
    TestLinker.log = false
  end

  it "has log_level set to :debug by default" do
    TestLinker.log_level.should == :debug
  end

  it "can change log_level set to :info" do
    TestLinker.log_level = :info
    TestLinker.log_level.should == :info
    TestLinker.log_level = :debug
  end
end
