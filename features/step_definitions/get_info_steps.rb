Given /^I have a TestLink server$/ do
  url = "http://testlink/"
  dev_key = "90b7941411928ae0a84d19f365a01a63"
  @server = TestLinkClient.new(url, dev_key)
end

When /^I ask for the list of projects$/ do
  @project_list = @server.projects
end

Then /^I get a list of projects$/ do
  @project_list.is_a?(Array).should be_true
  @project_list.first.is_a?(Hash).should be_true
end
