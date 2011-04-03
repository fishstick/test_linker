Given /^I know the name of a project$/ do
  @test_project_name = @server.projects.last["name"]
  @test_project_name.should_not be_nil
end

Given /^I know the name of a test plan in that project$/ do
  @original_test_plan_name = @test_plans.last["name"]
  @original_test_plan_name.should_not be_nil
end

Given /^I have the list of projects$/ do
  #When "I ask for the list of projects"
  @project_list = @server.projects
end

Given /^I have a list of test plans$/ do
  #When "I ask for the list of test plans"
  @test_plans = @server.project_test_plans(@project_list.last["id"])
end

When /^I ask for the list of projects$/ do
  @project_list = @server.projects
end

When /^I ask for the list of test plans$/ do
  @test_plans = @server.project_test_plans(@project_list.last["id"])
end

When /^I ask for that project by name$/ do
  @requested_test_project_name = @server.test_project_by_name(@test_project_name)
end

When /^I ask for that test plan by name$/ do
  @requested_test_plan_name = @server.test_plan_by_name(@original_test_plan_name,
    @project_list.last["name"])
end

Then /^I get a list of projects$/ do
  @project_list.is_a?(Array).should be_true
  @project_list.last.is_a?(Hash).should be_true
end

Then /^I get a list of test plans$/ do
  @test_plans.class.should == Array
  @test_plans.last.class.should == Hash
end

Then /^I get that project$/ do
  @requested_test_project_name.last["name"].should == @test_project_name
end

Then /^I get that test plan$/ do
  @requested_test_plan_name.first["name"].should == @original_test_plan_name
end
