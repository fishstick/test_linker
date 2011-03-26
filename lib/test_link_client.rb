require 'xmlrpc/client'
require 'test_link_client/version'
require 'test_link_client/error'
require 'test_link_client/helpers'

class TestLinkClient
  include TestLinkClient::Helpers

  DEFAULT_TIMEOUT = 30
  DEFAULT_API_PATH = "/lib/api/xmlrpc.php"
  DEFAULT_API_VERSION = "1.0b5"

  # @param [String] server_url URL to access TestLink API
  # @param [String] dev_key User key to access TestLink API
  def initialize(server_url, dev_key, options={})
    api_path = options[:api_path] || DEFAULT_API_PATH
    timeout = options[:timeout] || DEFAULT_TIMEOUT
    server_url = server_url + api_path
    @server  = XMLRPC::Client.new_from_uri(server_url, nil, timeout)
    @dev_key = dev_key #'90b7941411928ae0a84d19f365a01a63'
  end

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

  # Info about all projects.
  #
  # @return [Array<Hash>] List of all projects in TestLink and
  # their associated info.
  def projects
    args = { "devKey" => @dev_key }

    @server.call("tl.getProjects", args)
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
  def test_plan_by_name(project_name, plan_name)
    args = { 'devKey' => @dev_key, 'testplanname' => plan_name,
        'testprojectname' => project_name }

    @server.call('tl.getTestPlanByName', args)
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

  # Info about test cases within a test plan.
  #
  # @param [String] plan_id ID of the plan to get test cases for.
  # @param [Hash] options
  # @option options [Fixnum] testcaseid
  # @option options [Fixnum] buildid
  # @option options [Fixnum] keywordid
  # @option options [String] executed
  # @option options [String] assignedto
  # @option options [String] executestatus
  # @option options [String] executiontype
  # @return [Hash] List of all test cases in the plan and their associated
  # info.
  def test_cases_for_test_plan(plan_id, options={})
    args = { "devKey" => @dev_key, "testplanid" => plan_id }
    args.merge! options

    @server.call("tl.getTestCasesForTestPlan", args)
  end

  # @param [Fixnum] suite_id ID of the suite to retrieve test cases for.
  # @param [Fixnum] project_id
  # @param [Boolean] deep
  # @param [String] details
  # @return [Array<Hash>] List of test cases in the given suite and their associated info.
  def test_cases_for_test_suite(suite_id, project_id, deep, details)
    args = { "devKey" => @dev_key, "testsuiteid" => suite_id,
        "projectid" => project_id, "deep" => deep, "details" => details }

    @server.call("tl.getTestCasesForTestSuite", args)
  end

  # @param [Fixnum] test_project_id
  # @param [Fixnum] test_suite_id
  # @param [Boolean] deep
  # @param [String] details
  # @return
  def test_case_for_test_suite(test_project_id, test_suite_id, deep, details)
    args = { "devKey" => @dev_key, "testprojectid" => test_project_id,
        "testsuiteid" => test_suite_id, "deep" => deep, "details" => details }

    @server.call("tl.getTestCaseForTestSuite", args)
  end

  # TODO: Figure out how to call this.
  def test_case_attachments(test_plan_id, test_case_id, build_id)
    args = { "devKey" => @dev_key, "testplanid" => test_plan_id,
        "testcaseid" => test_case_id, "buildid" => build_id }

    @server.call("tl.getTestCaseAttachments", args)
  end

  # TODO: Figure out how to call this.
  def test_case_custom_field_design_value(test_plan_id, test_case_id, build_id)
    args = { "devKey" => @dev_key, "testplanid" => test_plan_id,
        "testcaseid" => test_case_id, "buildid" => build_id }

    @server.call("tl.getTestCaseCustomFieldDesignValue", args)
  end

  # Info about test case by name.
  # CAUTION: returns multiple values if test case is used more than once.
  #
  # @param [String] test_case_name Name to search across TL DB.
  # @param [Hash] options
  # @option options [String] test_project_name
  # @option optoins [String] test_suite_name
  # @raise [TestLinkClient::Error] When test case name doesn't exist.
  # @return [Array<Hash>] List of all test cases in the DB matching
  # test_case_name and their associated info.
  def test_case_id_by_name test_case_name, options={}
    args   = { "devKey" => @dev_key, "testcasename" => test_case_name }
    args.merge! options
    result = @server.call("tl.getTestCaseIDByName", args)

    if result.first['code']
      raise TestLinkClient::Error, "#{result.first['code']}: #{result.first['message']}"
    end

    result
  end
  alias_method :getTestCaseIDByName, :test_case_id_by_name

  # @param [Fixnum] plan_id
  # @param [Fixnum] test_case_id
  # @param [Fixnum] build_id
  # @return
  def last_execution_result(plan_id, test_case_id, build_id)
    args = { "devKey" => @dev_key, "testplanid" => plan_id,
        "testcaseid" => test_case_id, "buildid" => build_id }

    @server.call("tl.getLastExecutionResult", args)
  end
  alias_method :getLastExecutionResult, :last_execution_result

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

  # @param [String] project_name
  # TODO: verify that this really takes a Fixnum, not a String.
  # @param [Fixnum] test_case_prefix
  # @param [String] notes
  # @return
  def create_test_project(project_name, test_case_prefix, notes)
    args = { "devKey" => @dev_key, "testprojectname" => project_name,
        "testcaseprefix" => test_case_prefix, "notes" => notes }

    @server.call("tl.createTestProject", args)
  end

  # @param [String] project_name
  # @param [String] plan_name
  # @param [String] build_notes
  # @return
  def create_test_plan(project_name, plan_name, build_notes)
    args = { 'devKey' => @dev_key, 'testplanname' => plan_name,
        'testprojectname' => project_name, 'buildnotes' => build_notes }

    @server.call('tl.createTestPlan', args)
  end

  # @param [String] project_id
  # @param [String] suite_name
  # @param [String] details
  # @param [Hash] options
  # @option options [String] parentid
  # @option options [Fixnum] order
  # @option options [Boolean] checkduplicatedname
  # @return [Array<Hash>] Info about results of test suite creation.
  def create_test_suite(project_id, suite_name, details='', options={})
    args = { 'devKey' => @dev_key,
        'testprojectid' => project_id,
        'testsuitename' => suite_name,
        'details' => details }
    args.merge! options

    @server.call('tl.createTestSuite', args)
  end

  # TL create_build method:  gets info about test cases within a test plan
  #
  # @param [String] plan_id
  # @param [String] build_name
  # @param [String] build_notes
  # @return
  def create_build(plan_id, build_name, build_notes='')
    args = { "devKey" => @dev_key, "testplanid" => plan_id,
       "buildname" => build_name, "buildnotes" => build_notes }

    @server.call("tl.createBuild", args)
  end

  # TL create_test_case method:
  #
  # @param [String] login
  # @param [Fixnum] project_id
  # @param [Fixnum] suite_id
  # @param [String] test_case_name
  # @param [String] test_case_summary
  # @param [String] test_case_steps
  # @param [String] test_case_expected_results
  # @param [Hash] options
  # @option options [Fixnum] internalid
  # @option options [Fixnum] order
  # @option options [Boolean] checkduplicatedname
  # @option options [String] actiononduplicatedname
  # @option options [String] executiontype
  # @return
  def create_test_case(login, project_id, suite_id, test_case_name, test_case_summary,
      test_case_steps, test_case_expected_results)
    args = { "devKey" => @dev_key,
        "authorlogin" => login,
        "testprojectid" => project_id,
        "testsuiteid" => suite_id,
        "testcasename" => test_case_name,
        "summary" => test_case_summary,
        "steps" => test_case_steps,
        "expectedresults" => test_case_expected_results }

    @server.call("tl.createTestCase", args)
  end

  # TL add_test_case_to_test_plan method:
  # @todo Need to know how to get version number
  #
  # @param [String] project_id
  # @param [String] plan_id
  # @param [String] test_case_id
  # @param [String] test_case_version
  # @param [Hash] options Optional parameters for the method.
  # @option options [String] urgency
  # @option options [Fixnum] execution_order
  # @return
  def add_test_case_to_test_plan(project_id, plan_id, test_case_id,
      test_case_version, options={})
    args = { "devKey" => @dev_key, "testprojectid" => project_id, "testplanid" => plan_id,
        "testcaseid" => test_case_id, "version" => test_case_version }
    args.merge! options

    @server.call("tl.addTestCaseToTestPlan", args)
  end


  # Sets result in TestLink by test case ID and test plan ID.
  # NOTE: will guess at last build, needs to be set to guarantee accuracy.
  #
  # @param [String] test_case_id ID of the test case to post results to.
  # @param [String] test_plan_id ID of the test plan to post results to.
  # @param [String] status 'p', 'f', 's', or 'b' for Pass/Fail/Skip/Block
  # @param [Hash] options
  # @option options [Fixnum] buildid ID of the build to post results to.
  # @option options [Fixnum] bugid ID of the bug to link results to.
  # @option options [Boolean] guess ?
  # @option options [String] notes ?
  # @return [Hash] "status" of posting, "id" of the execution, "message"
  # giving success or failure info.
  # @raise [TestLinkClient::Error] If result fails to be posted for any reason.
  def report_test_case_result(test_case_id, test_plan_id, status, options={})
    args = { "devKey" => @dev_key, "testcaseid" => test_case_id,
        "testplanid" => test_plan_id, "status" => status, "guess" => true }
    args.merge! options
    result = @server.call("tl.reportTCResult", args).first

    unless result['message'] == 'Success!'
      raise TestLinkClient::Error, "#{result['code']}: #{result['message']}"
    end

    result
  end
  alias_method :reportTCResult, :report_test_case_result
end
