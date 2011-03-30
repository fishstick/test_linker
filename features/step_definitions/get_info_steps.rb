Given /^I have a TestLink server with API version (.+)$/ do |api_version|
  if api_version == "1.0"
    url = "http://ubuntu-desktop/testlink/"
    dev_key = "b8c144a536f8233d24b04b8268bfac34"
  else
    url = "http://testlink/"
    dev_key = "90b7941411928ae0a84d19f365a01a63"
  end
  @server = TestLinkClient.new(url, dev_key)
  @server.api_version.should == api_version
  @server.about.should match /#{api_version}/
end

When /^I ask for the list of projects$/ do
  @project_list = @server.projects
end

Then /^I get a list of projects$/ do
  @project_list.is_a?(Array).should be_true
  @project_list.first.is_a?(Hash).should be_true
end
