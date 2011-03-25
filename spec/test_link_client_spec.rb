require 'spec_helper'
require 'test_link_client'

describe TestLinkClient do
  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end
end
