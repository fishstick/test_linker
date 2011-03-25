require 'xmlrpc/client'
require_relative 'test_link_client/version'
require_relative 'test_link_client/error'


class TestLinkClient

  DEFAULT_TIMEOUT = 30
  DEFAULT_API_PATH = "/lib/api/xmlrpc.php"

  # @param [String] server_url URL to access TestLink API
  # @param [String] dev_key User key to access TestLink API
  def initialize(server_url, dev_key, options={})
    api_path = options[:api_path] || DEFAULT_API_PATH
    timeout = options[:timeout] || DEFAULT_TIMEOUT
    server_url = server_url + api_path
    @server  = XMLRPC::Client.new_from_uri(server_url, nil, timeout)
    @dev_key = dev_key #'90b7941411928ae0a84d19f365a01a63'
  end

  # Sets result in TestLink by test case ID and test plan ID.
  # NOTE: will guess at last build, needs to be set to guarantee accuracy.
  #
  # @param [String] test_case_id ID of the test case to post results to.
  # @param [String] test_plan_id ID of the test plan to post results to.
  # @param [String] status 'p', 'f', 's', or 'b' for Pass/Fail/Skip/Block
  # @param [String] build_id ID of the build to post results to.
  # @return [Hash] "status" of posting, "id" of the execution, "message"
  # giving success or failure info.
  # @raise [TestLinkClient::Error] If result fails to be posted for any reason.
  def report_test_case_result(test_case_id, test_plan_id, status, build_id=nil)
    args = { "devKey" => @dev_key, "testcaseid" => test_case_id,
        "testplanid" => test_plan_id, "status" => status, "guess" => true }
    args['build_id'] = build_id if build_id
    result = @server.call("tl.reportTCResult", args).first

    unless result['message'] == 'Success!'
      raise TestLinkClient::Error, "#{result['code']}: #{result['message']}"
    end

    result
  end
  alias_method :reportTCResult, :report_test_case_result

  # Basic connectivity test.
  #
  # @return [String] "Hello!"
  def say_hello
    args = ""

    @server.call("tl.sayHello", args)
  end
  alias_method :sayHello, :say_hello

  # Info about API version.
  #
  # @return [String] Info about TestLink API version
  def about
    args = ""

    @server.call("tl.about", args)
  end

  # Info about test case by name.
  # CAUTION: returns multiple values if test case is used more than once.
  #
  # @param [String] test_case_name Name to search across TL DB.
  # @raise [TestLinkClient::Error] When test case name doesn't exist.
  # @return [Array<Hash>] List of all test cases in the DB matching
  # test_case_name and their associated info.
  def test_case_id_by_name test_case_name
    args   = { "devKey" => @dev_key, "testcasename" => test_case_name }
    result = @server.call("tl.getTestCaseIDByName", args)

    if result.first['code']
      raise TestLinkClient::Error, "#{result.first['code']}: #{result.first['message']}"
    end

    result
  end
  alias_method :getTestCaseIDByName, :test_case_id_by_name

  # Info about all projects.
  #
  # @return [Array<Hash>] List of all projects in TestLink and
  # their associated info.
  def projects
    args = { "devKey" => @dev_key }

    @server.call("tl.getProjects", args)
  end

  # Info about a test project with a given name.
  #
  # @param [String] project_name Name of the project to search for.
  # @return [Array<Hash>] Info on matching project.
  def test_project_by_name project_name
    args = { 'devKey' => @dev_key, 'testprojectname' => project_name }

    @server.call('tl.getTestProjectByName', args)
  end

  # Info about a test plan with a given name.
  #
  # @param [String] plan_name Name of the plan to search for.
  # @return [Array<Hash>] Info on matching plan.
  def test_plan_by_name project_name, plan_name
    args = { 'devKey' => @dev_key, 'testplanname' => plan_name,
        'testprojectname' => project_name }

    @server.call('tl.getTestPlanByName', args)
  end

  # Info about test plans within a project.
  #
  # @param [String] project_id ID of the project to retrieve plans.
  # @return [Array<Hash>] Array of all plans in a project and their associated
  # info.
  def project_test_plans project_id
    args = { "devKey" => @dev_key, "testprojectid" => project_id }

    @server.call("tl.getProjectTestPlans", args)
  end

  # Info about test cases within a test plan.
  #
  # @param [String] plan_id ID of the plan to get test cases for.
  # @return [Hash] List of all test cases in the plan and their associated
  # info.
  def test_cases_for_test_plan plan_id
    args = { "devKey" => @dev_key, "testplanid" => plan_id }

    @server.call("tl.getTestCasesForTestPlan", args)
  end

  # TL builds_for_test_plan method:
  #
  # @param [String] plan_id ID of the plan to get builds for.
  # @return [Array<Hash>] List of all builds for the plan and their associated info.
  def builds_for_test_plan plan_id
    args = { "devKey" => @dev_key, "testplanid" => plan_id }

    @server.call("tl.getBuildsForTestPlan", args)
  end

  # TL latest_build_for_test_plan method:
  #
  # @param [String] plan_id ID of the plan to get build for.
  # @return [Hash] Info for the latest build for the given test plan.
  def latest_build_for_test_plan plan_id
    args = { "devKey" => @dev_key, "testplanid" => plan_id }

    @server.call("tl.getLatestBuildForTestPlan", args)
  end

  # TL test_suites_for_test_plan method:
  #
  # @param [String] plan_id ID of the plan to get suites for.
  # @return [Array<Hash>] List of all suites in plan and their associated info.
  def test_suites_for_test_plan plan_id
    args = { "devKey" => @dev_key, "testplanid" => plan_id }

    @server.call("tl.getTestSuitesForTestPlan", args)
  end

  # TL test_suites_for_test_plan method:
  #
  # @param [String] plan_id ID of the plan to get suites for.
  # @return [Array<Hash>] List of all suites in plan and their associated info.
  def test_suites_for_test_suite suite_id
    args = { "devKey" => @dev_key, "testsuiteid" => suite_id }

    @server.call("tl.getTestSuitesForTestSuite", args)
  end

  # TL first_level_test_suites_for_test_project method:
  #
  # @param [String] project_id ID of the project to get suites for.
  # @return [Array<Hash>] List of first level suites in project and their associated info.
  def first_level_test_suites_for_test_project project_id
    args = { "devKey" => @dev_key, "testprojectid" => project_id }

    @server.call("tl.getFirstLevelTestSuitesForTestProject", args)
  end

  # TL create_build method:  gets info about test cases within a test plan
  #
  # @param [String] plan_id
  # @param [String] build_name
  # @param [String] build_notes
  # @return
  def create_build plan_id, build_name, build_notes=''
    args = { "devKey" => @dev_key, "testplanid" => plan_id,
       "buildname" => build_name, "buildnotes" => build_notes }

    @server.call("tl.createBuild", args)
  end

  def create_test_plan(project_name, plan_name)
    args = { 'devKey' => @dev_key, 'testplanname' => plan_name,
        'testprojectname' => project_name }

    @server.call('tl.createTestPlan', args)
  end

  # @param [String] project_id
  # @param [String] suite_name
  # @param [String] parent_id
  # @param [String] details
  # @return [Array<Hash>] Info about results of test suite creation.
  def create_test_suite(project_id, suite_name, parent_id=nil, details='')
    args = { 'devKey' => @dev_key,
        'testprojectid' => project_id,
        'testsuitename' => suite_name,
        'details' => details }
    args['parentid'] = parent_id if parent_id

    @server.call('tl.createTestSuite', args)
  end

  # TL test_cases_for_test_suite method:
  #
  # @param [String] suite_id ID of the suite to retrieve test cases for.
  # @return [Array<Hash>] List of test cases in the given suite and their associated info.
  def test_cases_for_test_suite suite_id
    args = { "devKey" => @dev_key, "testsuiteid" => suite_id }

    @server.call("tl.getTestCasesForTestSuite", args)
  end

  # TL create_test_case method:
  #
  # @param [String] login
  # @param [String] project_id
  # @param [String] suite_id
  # @param [String] test_case_name
  # @param [String] test_case_summary
  # @param [String] test_case_steps
  # @param [String] test_case_execution_results
  # @return
  def create_test_case(login, project_id, suite_id, test_case_name, test_case_summary,
      test_case_steps, test_case_execution_results)
    args = { "devKey" => @dev_key,
        "authorlogin" => login,
        "testprojectid" => project_id,
        "testsuiteid" => suite_id,
        "testcasename" => test_case_name,
        "summary" => test_case_summary,
        "steps" => test_case_steps,
        "expectedresults" => test_case_execution_results }

    @server.call("tl.createTestCase", args)
  end

  # TL add_test_case_to_test_plan method:
  # @todo Need to know how to get version number
  #
  # @param [String] project_id
  # @param [String] plan_id
  # @param [String] test_case_id
  # @param [String] test_case_version
  # @return
  def add_test_case_to_test_plan(project_id, plan_id, test_case_id, test_case_version)
    args = { "devKey" => @dev_key, "testprojectid" => project_id, "testplanid" => plan_id,
        "testcaseid" => test_case_id, "version" => test_case_version }

    @server.call("tl.addTestCaseToTestPlan", args)
  end
end
