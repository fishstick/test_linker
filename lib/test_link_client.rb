require 'xmlrpc/client'
require 'rubygems'
require 'versionomy'
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
    @version = Versionomy.parse(options[:version] || DEFAULT_API_PATH)
    server_url = server_url + api_path
    @server  = XMLRPC::Client.new_from_uri(server_url, nil, timeout)
    @dev_key = dev_key #'90b7941411928ae0a84d19f365a01a63'
  end

  # @version 1.0
  # @param [Hash] options
  # @option options [Fixnum] testcaseid
  # @option options [Fixnum] testcaseexternalid
  # @option options [Fixnum] version The test case version. Default is most recent.
  # @return
  def test_case(options)
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported in version #{@version}."
    end

    args = { "devKey" => @dev_key }
    args.merge! options

    @server.call("tl.getTestCase", args)
  end
  alias_method :getTestCase, :test_case

  # Gets full path from the given node till the top using nodes_hierarchy_table.
  #
  # @version 1.0
  # @param [Fixnum] node_id
  # @return 
  def full_path node_id
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported in version #{@version}."
    end

    args = { "devKey" => @dev_key, "nodeID" => node_id }

    @server.call("tl.getFullPath", args)
  end
  alias_method :getFullPath, :full_path

  # Return a TestSuite by ID.
  #
  # @version 1.0
  # @param [Fixnum] suite_id
  # @return
  def test_suite_by_id suite_id
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported in version #{@version}."
    end

    args = { "devKey" => @dev_key, "testsuiteid" => suite_id }

    @server.call("tl.getTestSuiteByID", args)
  end
  alias_method :getTestSuiteByID, :test_suite_by_id

  # @version 1.0
  # @param [Fixnum] execution_id
  # @return [Hash] "status", "id", "message"
  def delete_execution execution_id
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported in version #{@version}."
    end

    args = { "devKey" => @dev_key, "executionid" => execution_id }

    @server.call("tl.deleteExecution", args)
  end
  alias_method :deleteExecution, :delete_execution

  # @version 1.0
  # @param [String] user_name
  # @return [Boolean,Hash] true if user exists, otherwise an error structure.
  def does_user_exist user_name
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported in version #{@version}."
    end

    args = { "devKey" => @dev_key, "user" => user_name }

    @server.call("tl.doesUserExist", args)
  end
  alias_method :doesUserExist, :does_user_exist

  # Check if Developer Key exist.
  #
  # @version 1.0
  # @param [Fixnum] dev_key
  # @return [Hash] "true" if it exists, otherwise error structure.
  def check_dev_key dev_key
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported in version #{@version}."
    end

    args = { "devKey" => dev_key }

    @server.call("tl.checkDevKey", args)
  end
  alias_method :checkDevKey, :check_dev_key

  # Uploads an attachment for an execution.
  #
  # @version 1.0
  # @param [Fixnum] execution_id
  # @param [String] file_name
  # @param [String] mime_type
  # @param [String] content The Base64 encoded content of the attachment.
  # @param [Hash] options
  # @option options [String] title
  # @option options [String] description
  # @return
  def upload_execution_attachment(execution_id, file_name, mime_type, content,
    options={})
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported in version #{@version}."
    end

    args = { "devKey" => @dev_key, "executionid" => execution_id,
      "filename" => file_name, "filetype" => mime_type, "content" => content }
    args.merge! options

    @server.call("tl.uploadExecutionAttachment", args)
  end
  alias_method :uploadExecutionAttachment, :upload_execution_attachment

  # Uploads an attachment for a Requirement. The attachment
  # content must be Base64 encoded by the client before sending it.
  #
  # @version 1.0
  # @param [Fixnum] requirement_id
  # @param [String] file_name
  # @param [String] mime_type
  # @param [String] content The Base64 encoded content of the attachment.
  # @param [Hash] options
  # @option options [String] title
  # @option options [String] description
  # @return
  def upload_requirement_attachment(requirement_id, file_name, mime_type, content,
      options={})
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported in version #{@version}."
    end

    args = { "devKey" => @dev_key, "requirementid" => requirement_id,
        "filename" => file_name, "filetype" => mime_type, "content" => content }
    args.merge! options

    @server.call("tl.uploadRequirementAttachment", args)
  end
  alias_method :uploadRequirementAttachment, :upload_requirement_attachment

  # Uploads an attachment for a Requirement Specification. The attachment
  # content must be Base64 encoded by the client before sending it.
  #
  # @version 1.0
  # @param [Fixnum] requirement_id
  # @param [String] file_name
  # @param [String] mime_type
  # @param [String] content The Base64 encoded content of the attachment.
  # @param [Hash] options
  # @option options [String] title
  # @option options [String] description
  # @return
  def upload_requirement_specification_attachment(requirement_specification_id, file_name, mime_type, content,
      options={})
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported in version #{@version}."
    end

    args = { "devKey" => @dev_key, "reqspecid" => requirement_specification_id,
        "filename" => file_name, "filetype" => mime_type, "content" => content }
    args.merge! options

    @server.call("tl.uploadRequirementSpecificationAttachment", args)
  end

  alias_method :uploadRequirementSpecificationAttachment,
      :upload_requirement_specification_attachment

  # Assign Requirements to a test case.  Capable of assigning multiple
  # requirements. Requirements can belong to different Requirement Specs.
  #
  # @param [Fixnum] test_case_external_id
  # @param [Fixnum] project_id
  # @param [String] requirements
  # @return
  def assign_requirements(test_case_external_id, project_id, requirements)
    args = { "devKey" => @dev_key, "testcaseexternalid" => test_case_external_id,
        "testprojectid" => project_id, "requirements" => requirements }

    @server.call("tl.assignRequirements", args)
  end
  alias_method :assignRequirements, :assign_requirements

  # Uploads an attachment for a Test Project. The attachment must be Base64
  # encoded by the client before sending it.
  #
  # @version 1.0
  # @param [Fixnum] test_project_id
  # @param [String] file_name
  # @param [String] mime_type
  # @param [String] content The Base64 encoded content of the attachment.
  # @param [Hash] options
  # @option options [String] title
  # @option options [String] description
  # @return
  def upload_test_project_attachment(project_id, file_name, mime_type, content,
      options={})
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported in version #{@version}."
    end

    args = { "devKey" => @dev_key, "testprojectid" => project_id,
        "filename" => file_name, "filetype" => mime_type, "content" => content }
    args.merge! options

    @server.call("tl.uploadTestProjectAttachment", args)
  end
  alias_method :uploadTestProjectAttachment, :upload_test_project_attachment

  # Uploads an attachment for a Test Suite. The attachment must be Base64
  # encoded by the client before sending it.
  #
  # @version 1.0
  # @param [Fixnum] suite_id
  # @param [String] file_name
  # @param [String] mime_type
  # @param [String] content The Base64 encoded content of the attachment.
  # @param [Hash] options
  # @option options [String] title
  # @option options [String] description
  # @return
  def upload_test_suite_attachment(suite_id, file_name, mime_type, content,
      options={})
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported in version #{@version}."
    end

    args = { "devKey" => @dev_key, "testsuiteid" => suite_id,
        "filename" => file_name, "filetype" => mime_type, "content" => content }
    args.merge! options

    @server.call("tl.uploadTestSuiteAttachment", args)
  end
  alias_method :uploadTestSuiteAttachment, :upload_test_suite_attachment

  # Uploads an attachment for a Test Case. The attachment must be Base64
  # encoded by the client before sending it.
  #
  # @version 1.0
  # @param [Fixnum] test_case_id
  # @param [String] file_name
  # @param [String] mime_type
  # @param [String] content The Base64 encoded content of the attachment.
  # @param [Hash] options
  # @option options [String] title
  # @option options [String] description
  # @return
  def upload_test_case_attachment(test_case_id, file_name, mime_type, content,
      options={})
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported in version #{@version}."
    end

    args = { "devKey" => @dev_key, "testcaseid" => test_case_id,
        "filename" => file_name, "filetype" => mime_type, "content" => content }
    args.merge! options

    @server.call("tl.uploadTestCaseAttachment", args)
  end
  alias_method :uploadTestCaseAttachment, :upload_test_case_attachment

  # Uploads an attachment for specified table. You must specify the table that
  # the attachment is connected (nodes_hierarchy, builds, etc) and the foreign
  # key id in this table The attachment must be Base64 encoded by the client
  # before sending it.
  #
  # @version 1.0
  # @param [Fixnum] foreign_key_id
  # @param [String] foreign_key_table
  # @param [String] file_name
  # @param [String] mime_type
  # @param [String] content The Base64 encoded content of the attachment.
  # @param [Hash] options
  # @option options [String] title
  # @option options [String] description
  # @return
  def upload_attachment(foreign_key_id, foreign_key_table, file_name, mime_type,
      content, options={})
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported in version #{@version}."
    end

    args = { "devKey" => @dev_key, "fkid" => foreign_key_id,
        "fktable" => foreign_key_table, "filename" => file_name,
        "filetype" => mime_type, "content" => content }
    args.merge! options

    @server.call("tl.uploadAttachment", args)
  end
  alias_method :uploadAttachment, :upload_attachment

  # Basic connectivity test.
  #
  # @return [String] "Hello!"
  def say_hello
    @server.call("tl.sayHello", "")
  end
  alias_method :sayHello, :say_hello
  alias_method :ping, :say_hello

  # Sends a message to the server to have it repeated back.
  #
  # @param [String] message The message to get the server to repeat back.
  # @return [String] The message sent to the server.
  def repeat message
    args = { "str" => message }

    @server.call("tl.repeat", args)
  end

  # Repeats a message back.
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
  # @param [Fixnum] project_id ID of the project to retrieve plans.
  # @return [Array<Hash>] Array of all plans in a project and their associated
  # info.
  def project_test_plans project_id
    args = { "devKey" => @dev_key, "testprojectid" => project_id }

    @server.call("tl.getProjectTestPlans", args)
  end
  alias_method :getProjectTestPlans, :project_test_plans

  # Info about a test project with a given name.
  #
  # @version 1.0
  # @param [String] project_name Name of the project to search for.
  # @return [Array<Hash>] Info on matching project.
  def test_project_by_name project_name
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported in version #{@version}."
    end

    args = { 'devKey' => @dev_key, 'testprojectname' => project_name }

    @server.call('tl.getTestProjectByName', args)
  end
  alias_method :getTestProjectByName, :test_project_by_name

  # Info about a test plan with a given name.
  #
  # @version 1.0
  # @param [String] plan_name Name of the plan to search for.
  # @return [Array<Hash>] Info on matching plan.
  def test_plan_by_name(project_name, plan_name)
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported in version #{@version}."
    end

    args = { 'devKey' => @dev_key, 'testplanname' => plan_name,
        'testprojectname' => project_name }

    result = @server.call('tl.getTestPlanByName', args)

    if result.first['code']
      raise TestLinkClient::Error, "#{result.first['code']}: #{result.first['message']}"
    end
  end
  alias_method :getTestPlanByName, :test_plan_by_name

  # TL test_suites_for_test_plan method:
  #
  # @param [String] plan_id ID of the plan to get suites for.
  # @return [Array<Hash>] List of all suites in plan and their associated info.
  def test_suites_for_test_plan plan_id
    args = { "devKey" => @dev_key, "testplanid" => plan_id }

    @server.call("tl.getTestSuitesForTestPlan", args)
  end
  alias_method :getTestSuitesForTestPlan, :test_suites_for_test_plan

  # TL test_suites_for_test_plan method:
  #
  # @version 1.0
  # @param [String] plan_id ID of the plan to get suites for.
  # @return [Array<Hash>] List of all suites in plan and their associated info.
  def test_suites_for_test_suite suite_id
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported in version #{@version}."
    end

    args = { "devKey" => @dev_key, "testsuiteid" => suite_id }

    @server.call("tl.getTestSuitesForTestSuite", args)
  end
  alias_method :getTestSuitesForTestSuite, :test_suites_for_test_suite

  # TL first_level_test_suites_for_test_project method:
  #
  # @param [String] project_id ID of the project to get suites for.
  # @return [Array<Hash>] List of first level suites in project and their associated info.
  def first_level_test_suites_for_test_project project_id
    args = { "devKey" => @dev_key, "testprojectid" => project_id }

    @server.call("tl.getFirstLevelTestSuitesForTestProject", args)
  end
  alias_method :getFirstLevelTestSuitesForTestProject,
      :first_level_test_suites_for_test_project

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
  # @return [Hash<Array>] List of all test cases in the plan and their associated
  # info. The first element in the Array is the test case ID, the second element
  # is the test case info.
  def test_cases_for_test_plan(plan_id, options={})
    args = { "devKey" => @dev_key, "testplanid" => plan_id }
    args.merge! options

    @server.call("tl.getTestCasesForTestPlan", args)
  end
  alias_method :getTestCasesForTestPlan, :test_cases_for_test_plan

  # @param [Fixnum] suite_id ID of the suite to retrieve test cases for.
  # @param [Fixnum] project_id
  # @param [Boolean] deep
  # @param [String] details
  # @return [Array<Hash>] List of test cases in the given suite and their associated info.
  def test_cases_for_test_suite(suite_id, project_id, deep=true, details="")
    args = { "devKey" => @dev_key, "testsuiteid" => suite_id,
        "projectid" => project_id, "deep" => deep, "details" => details }

    @server.call("tl.getTestCasesForTestSuite", args)
  end
  alias_method :getTestCasesForTestSuite, :test_cases_for_test_suite

  # Gets the summarized results grouped by platform.
  #
  # @version 1.0
  # @return [Hash] Contains "type" => platform, "total_tc" => X, "details =>
  # Array of counts.
  def totals_for_test_plan plan_id
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported for version #{@version}."
    end

    args = { "devKey" => @dev_key, "testplanid" => plan_id }

    @server.call("tl.getTotalsForTestPlan", args)
  end
  alias_method :getTotalsForTestPlan, :totals_for_test_plan

  # @param [Fixnum] test_plan_id
  # @param [Fixnum] test_case_id
  # @param [Fixnum] build_id
  # @return [String]
  def test_case_attachments(plan_id, test_case_id, build_id)
    args = { "devKey" => @dev_key, "testplanid" => plan_id,
        "testcaseid" => test_case_id, "buildid" => build_id }

    @server.call("tl.getTestCaseAttachments", args)
  end
  alias_method :getTestCaseAttachments, :test_case_attachments

  # @param [Fixnum] test_plan_id
  # @param [Fixnum] test_case_id
  # @param [Fixnum] build_id
  # @return [Array<Hash>]
  def test_case_custom_field_design_value(plan_id, test_case_id, build_id)
    args = { "devKey" => @dev_key, "testplanid" => plan_id,
        "testcaseid" => test_case_id, "buildid" => build_id }

    @server.call("tl.getTestCaseCustomFieldDesignValue", args)
  end
  alias_method :getTestCaseCustomFieldDesignValue, :test_case_custom_field_design_value

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
  def test_case_id_by_name(test_case_name, options={})
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
  alias_method :getBuildsForTestPlan, :builds_for_test_plan

  # TL latest_build_for_test_plan method:
  #
  # @param [String] plan_id ID of the plan to get build for.
  # @return [Hash] Info for the latest build for the given test plan.
  def latest_build_for_test_plan plan_id
    args = { "devKey" => @dev_key, "testplanid" => plan_id }

    @server.call("tl.getLatestBuildForTestPlan", args)
  end
  alias_method :getLatestBuildForTestPlan, :latest_build_for_test_plan

  # @param [String] project_name
  # @param [String] test_case_prefix
  # @param [Hash] options
  # @option options [String] notes
  # @option options [Hash] options ALL int treated as boolean: requirementsEnabled,testPriorityEnabled,automationEnabled,inventoryEnabled
  # @option options [Fixnum] active
  # @option options [Fixnum] public
  # @return
  def create_test_project(project_name, test_case_prefix, options={})
    args = { "devKey" => @dev_key, "testprojectname" => project_name,
        "testcaseprefix" => test_case_prefix, "notes" => notes }
    args.merge! options

    @server.call("tl.createTestProject", args)
  end
  alias_method :createTestProject, :create_test_project

  # @version 1.0
  # @param [String] project_name
  # @param [String] plan_name
  # @param [Hash] options
  # @option options [String] notes
  # @option options [String] active
  # @option options [String] public
  # @return
  def create_test_plan(project_name, plan_name, options={})
    if @version < "1.0"
      raise TestLinkClient::Error, "Method not supported in version #{@version}."
    end

    args = { 'devKey' => @dev_key, 'testplanname' => plan_name,
        'testprojectname' => project_name, 'buildnotes' => build_notes }
    args.merge! options

    @server.call('tl.createTestPlan', args)
  end
  alias_method :createTestPlan, :create_test_plan

  # @param [String] project_id
  # @param [String] suite_name
  # @param [String] details
  # @param [Hash] options
  # @option options [String] parentid
  # @option options [Fixnum] order
  # @option options [Boolean] checkduplicatedname
  # @return [Array<Hash>] Info about results of test suite creation.
  def create_test_suite(project_id, suite_name, details='', options={})
    args = { 'devKey' => @dev_key, 'testprojectid' => project_id,
        'testsuitename' => suite_name, 'details' => details }
    args.merge! options

    @server.call('tl.createTestSuite', args)
  end
  alias_method :createTestSuite, :create_test_suite

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
  alias_method :createBuild, :create_build

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
      test_case_steps, test_case_expected_results, options={})
    args = { "devKey" => @dev_key,
        "authorlogin" => login,
        "testprojectid" => project_id,
        "testsuiteid" => suite_id,
        "testcasename" => test_case_name,
        "summary" => test_case_summary,
        "steps" => test_case_steps,
        "expectedresults" => test_case_expected_results }
    args.merge! options

    @server.call("tl.createTestCase", args)
  end
  alias_method :createTestCase, :create_test_case

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
  alias_method :addTestCaseToTestPlan, :add_test_case_to_test_plan

  # Sets result in TestLink by test case ID and test plan ID.
  # NOTE: will guess at last build, needs to be set to guarantee accuracy.
  # NOTE: Renamed to setTestCaseExecutionResult in version 1.0.
  #
  # @see #test_case_execution_result=
  # @version <1.0
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
    if @version >= "1.0"
      message = "Method not supported in version #{@version}. "
      message << "Use #test_case_execution_result="
      raise TestLinkClient::Error, message
    end

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

  # Sets result in TestLink by test case ID and test plan ID.
  # NOTE: will guess at last build, needs to be set to guarantee accuracy.
  #
  # @see #report_test_case_result
  # @version 1.0
  # @param [String] test_case_id ID of the test case to post results to.
  # @param [String] test_plan_id ID of the test plan to post results to.
  # @param [String] status 'p', 'f', 's', or 'b' for Pass/Fail/Skip/Block
  # @param [Hash] options
  # @option options [Fixnum] buildid ID of the build to post results to.
  # @option options [String] buildname Name of the build to post results to.
  # @option options [Fixnum] bugid ID of the bug to link results to.
  # @option options [Boolean] guess Defines whether to guess optinal params or require them.
  # @option options [String] notes ?
  # @option options [String] platformid (version 1.0)
  # @option options [String] platformid (version 1.0)
  # @option options [String] customfields (version 1.0)
  # @option options [String] overwrite (version 1.0)
  # @return [Hash] "status" of posting, "id" of the execution, "message"
  # giving success or failure info.
  # @raise [TestLinkClient::Error] If result fails to be posted for any reason.
  def test_case_execution_result=(test_case_id, test_plan_id, status, options={})
    if @version < "1.0"
      message = "Method not supported in version #{@version}. "
      message << "Use #report_test_case_result"
      raise TestLinkClient::Error, message
    end

    args = { "devKey" => @dev_key, "testcaseid" => test_case_id,
        "testplanid" => test_plan_id, "status" => status, "guess" => true }
    args.merge! options
    result = @server.call("tl.setTestCaseExecutionResult", args).first

    unless result['message'] == 'Success!'
      raise TestLinkClient::Error, "#{result['code']}: #{result['message']}"
    end

    result
  end
  alias_method :setTestCaseExecutionResult, :test_case_execution_result=
end
