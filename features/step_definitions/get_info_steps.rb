Given /^I know the name of a project$/ do
  @test_project_name = @server.projects.first["name"]
  @test_project_name.should_not be_nil
end

Given /^I know the name of a test plan$/ do
  When "I ask for the list of test plans"
  @original_test_plan_name = @test_plans.first["name"]
  @original_test_plan_name.should_not be_nil
end

When /^I ask for the list of projects$/ do
  @project_list = @server.projects
end

When /^I ask for the list of test plans$/ do
  @test_plans = @server.project_test_plans(@project_list.first["id"])
end

When /^I ask for that project by name$/ do
  @requested_test_project_name = @server.test_project_by_name(@test_project_name)
end

When /^I ask for that test plan by name$/ do
  @requested_test_plan_name = @server.test_plan_by_name(@original_test_plan_name)
end

Then /^I get a list of projects$/ do
  @project_list.is_a?(Array).should be_true
  @project_list.first.is_a?(Hash).should be_true
end

Then /^I get a list of test plans$/ do
  @test_plans.class.should == Array
  @test_plans.first.class.should == Hash
end

Then /^I get that project$/ do
  @requested_test_project_name.first["name"].should == @test_project_name
end

Then /^I get that test plan$/ do
  @requested_test_plan_name.first["name"].should == @original_test_plan_name
end
