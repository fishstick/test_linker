Given /^I have a TestLink server with API version (.+)$/ do |api_version|
  if api_version == "1.0"
    url = "http://ubuntu-desktop/testlink/"
    dev_key = "b8c144a536f8233d24b04b8268bfac34"
  else
    url = "http://testlink/"
    dev_key = "90b7941411928ae0a84d19f365a01a63"
  end
  #TestLinker.log = false
  TestLinkClient.log = true
  @server = TestLinkClient.new(url, dev_key)
  @server.api_version.should == api_version
  @server.about.should match /#{api_version} /
end
