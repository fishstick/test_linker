require 'xmlrpc/client'
require 'rubygems'
require 'versionomy'
require 'test_link_client/version'
require 'test_link_client/error'
require 'test_link_client/helpers'

# TODO: Check parameter order; make sure most relevant is first.
class TestLinkClient
  include TestLinkClient::Helpers

  # Default value for timing out after not receiving an XMLRPC response from
  #   the server.
  DEFAULT_TIMEOUT = 30

  # Path the the XMLRPC interface (via the xmlrpc.php file) on the server.
  DEFAULT_API_PATH = "/lib/api/xmlrpc.php"

  # @param [String] server_url URL to access TestLink API
  # @param [String] dev_key User key to access TestLink API
  # @param [Hash] options
  # @option options [String] api_path Alternate path to the xmlrpc.php file on
  #   the server.
  # @option options [Fixnum] timeout Seconds to timeout after not receiving a
  #   response from the server.
  # @option options [String] version Force a different API version.
  def initialize(server_url, dev_key, options={})
    api_path = options[:api_path] || DEFAULT_API_PATH
    timeout = options[:timeout] || DEFAULT_TIMEOUT
    @dev_key = dev_key #'90b7941411928ae0a84d19f365a01a63'
    server_url = server_url + api_path
    @server  = XMLRPC::Client.new_from_uri(server_url, nil, timeout)
    @version = Versionomy.parse(options[:version] || api_version)
  end

  # Gets a test case by it's internal or external ID.
  #
  # @since TestLink API version 1.0
  # @param [Hash] options
  # @option options [Fixnum] testcaseid
  # @option options [Fixnum] testcaseexternalid
  # @option options [Fixnum] version The test case version. Default is most recent.
  # @return
  def test_case(options)
    args = { "devKey" => @dev_key }
    args.merge! options
    make_call("tl.getTestCase", args, "1.0")
  end
  alias_method :getTestCase, :test_case

  # Gets full path from the given node till the top using nodes_hierarchy_table.
  #
  # @since TestLink API version 1.0
  # @param [Fixnum] node_id
  # @return 
  def full_path node_id
    args = { "devKey" => @dev_key, "nodeID" => node_id }
    make_call("tl.getFullPath", args, "1.0")
  end
  alias_method :getFullPath, :full_path

  # Gets a test suite by the given ID.
  #
  # @since TestLink API version 1.0
  # @param [Fixnum] suite_id
  # @return
  def test_suite_by_id suite_id
    args = { "devKey" => @dev_key, "testsuiteid" => suite_id }
    make_call("tl.getTestSuiteByID", args, "1.0")
  end
  alias_method :getTestSuiteByID, :test_suite_by_id

  # @since TestLink API version 1.0
  # @param [Fixnum] execution_id
  # @return [Hash] "status", "id", "message"
  def delete_execution execution_id
    args = { "devKey" => @dev_key, "executionid" => execution_id }
    make_call("tl.deleteExecution", args, "1.0")
  end
  alias_method :deleteExecution, :delete_execution

  # @since TestLink API version 1.0
  # @param [String] user_name
  # @return [Boolean,Hash] true if user exists, otherwise an error structure.
  def does_user_exist user_name
    args = { "devKey" => @dev_key, "user" => user_name }
    make_call("tl.doesUserExist", args, "1.0")
  end
  alias_method :doesUserExist, :does_user_exist

  # Checks if the given Developer Key exist.
  #
  # @since TestLink API version 1.0
  # @param [Fixnum] dev_key
  # @return [Hash] "true" if it exists, otherwise error structure.
  def check_dev_key dev_key
    args = { "devKey" => dev_key }
    make_call("tl.checkDevKey", args, "1.0")
  end
  alias_method :checkDevKey, :check_dev_key

  # Uploads an attachment for a test case execution.
  #
  # @since TestLink API version 1.0
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
    args = { "devKey" => @dev_key, "executionid" => execution_id,
      "filename" => file_name, "filetype" => mime_type, "content" => content }
    args.merge! options
    make_call("tl.uploadExecutionAttachment", args, "1.0")
  end
  alias_method :uploadExecutionAttachment, :upload_execution_attachment

  # Uploads an attachment for a Requirement. The attachment content must be
  # Base64 encoded by the client before sending it.
  #
  # @since TestLink API version 1.0
  # @param [Fixnum] requirement_id
  # @param [String] file_name
  # @param [String] mime_type
  # @param [String] content The Base64 encoded content of the attachment.
  # @param [Hash] options
  # @option options [String] title
  # @option options [String] description
  # @return
  def upload_requirement_attachment(requirement_id, file_name, mime_type,
      content, options={})
    args = { "devKey" => @dev_key, "requirementid" => requirement_id,
        "filename" => file_name, "filetype" => mime_type, "content" => content }
    args.merge! options
    make_call("tl.uploadRequirementAttachment", args, "1.0")
  end
  alias_method :uploadRequirementAttachment, :upload_requirement_attachment

  # Uploads an attachment for a Requirement Specification. The attachment
  # content must be Base64 encoded by the client before sending it.
  #
  # @since TestLink API version 1.0
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
    args = { "devKey" => @dev_key, "reqspecid" => requirement_specification_id,
        "filename" => file_name, "filetype" => mime_type, "content" => content }
    args.merge! options
    make_call("tl.uploadRequirementSpecificationAttachment", args, "1.0")
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
    make_call("tl.assignRequirements", args, "1.0b5")
  end
  alias_method :assignRequirements, :assign_requirements

  # Uploads an attachment for a Test Project. The attachment must be Base64
  # encoded by the client before sending it.
  #
  # @since TestLink API version 1.0
  # @param [Fixnum] project_id
  # @param [String] file_name
  # @param [String] mime_type
  # @param [String] content The Base64 encoded content of the attachment.
  # @param [Hash] options
  # @option options [String] title
  # @option options [String] description
  # @return
  def upload_test_project_attachment(project_id, file_name, mime_type, content,
      options={})
    args = { "devKey" => @dev_key, "testprojectid" => project_id,
        "filename" => file_name, "filetype" => mime_type, "content" => content }
    args.merge! options
    make_call("tl.uploadTestProjectAttachment", args, "1.0")
  end
  alias_method :uploadTestProjectAttachment, :upload_test_project_attachment

  # Uploads an attachment for a Test Suite. The attachment must be Base64
  # encoded by the client before sending it.
  #
  # @since TestLink API version 1.0
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
    args = { "devKey" => @dev_key, "testsuiteid" => suite_id,
        "filename" => file_name, "filetype" => mime_type, "content" => content }
    args.merge! options
    make_call("tl.uploadTestSuiteAttachment", args, "1.0")
  end
  alias_method :uploadTestSuiteAttachment, :upload_test_suite_attachment

  # Uploads an attachment for a Test Case. The attachment must be Base64
  # encoded by the client before sending it.
  #
  # @since TestLink API version 1.0
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
    args = { "devKey" => @dev_key, "testcaseid" => test_case_id,
        "filename" => file_name, "filetype" => mime_type, "content" => content }
    args.merge! options
    make_call("tl.uploadTestCaseAttachment", args, "1.0")
  end
  alias_method :uploadTestCaseAttachment, :upload_test_case_attachment

  # Uploads an attachment for specified table. You must specify the table that
  # the attachment is connected (nodes_hierarchy, builds, etc) and the foreign
  # key id in this table The attachment must be Base64 encoded by the client
  # before sending it.
  #
  # @since TestLink API version 1.0
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
    args = { "devKey" => @dev_key, "fkid" => foreign_key_id,
        "fktable" => foreign_key_table, "filename" => file_name,
        "filetype" => mime_type, "content" => content }
    args.merge! options
    make_call("tl.uploadAttachment", args, "1.0")
  end
  alias_method :uploadAttachment, :upload_attachment

  # Basic connectivity test.
  #
  # @return [String] "Hello!"
  def say_hello
    make_call("tl.sayHello", "", "1.0b5")
  end
  alias_method :sayHello, :say_hello
  alias_method :ping, :say_hello

  # Sends a message to the server to have it repeated back.
  #
  # @param [String] message The message to get the server to repeat back.
  # @return [String] The message sent to the server.
  def repeat message
    make_call("tl.repeat", { "str" => message }, "1.0b5")
  end

  # Returns info about the server's TestLink API.
  #
  # @return [String] Info about TestLink API version
  def about
    make_call("tl.about", "", "1.0b5")
  end

  # Gets a list of all projects.
  #
  # @return [Array<Hash>] List of all projects in TestLink and
  # their associated info.
  def projects
    make_call("tl.getProjects", { "devKey" => @dev_key }, "1.0b5" )
  end
  alias_method :getProjects, :projects

  # Gets a list of test plans within a project.
  #
  # @param [Fixnum] project_id ID of the project to retrieve plans.
  # @return [Array<Hash>] Array of all plans in a project and their associated
  #   info.
  # @raise [TestLinkClient::Error] If a project by the given ID doesn't exist.
  def project_test_plans project_id
    args = { "devKey" => @dev_key, "testprojectid" => project_id }
    response = make_call("tl.getProjectTestPlans", args, "1.0b5")
    response == "" ? [{}] : response
  end
  alias_method :getProjectTestPlans, :project_test_plans

  # Info about a test project with a given name.
  #
  # @since TestLink API version 1.0
  # @param [String] project_name Name of the project to search for.
  # @return [Array<Hash>] Info on matching project.
  def test_project_by_name project_name
    args = { 'devKey' => @dev_key, 'testprojectname' => project_name }
    make_call('tl.getTestProjectByName', args, "1.0")
  end
  alias_method :getTestProjectByName, :test_project_by_name

  # Gets the test plan with the given name.
  #
  # @since TestLink API version 1.0
  # @param [String] plan_name Name of the plan to search for.
  # @param [String] project_name Name of the project the plan is in.
  # @return [Array<Hash>] Info on matching plan.
  def test_plan_by_name(plan_name, project_name)
    args = { 'devKey' => @dev_key, 'testplanname' => plan_name,
        'testprojectname' => project_name }
    make_call('tl.getTestPlanByName', args, "1.0")
  end
  alias_method :getTestPlanByName, :test_plan_by_name

  # List test suites within a test plan alphabetically.
  #
  # @param [String] plan_id ID of the plan to get suites for.
  # @return [Array<Hash>] List of all suites in plan and their associated info.
  def test_suites_for_test_plan plan_id
    args = { "devKey" => @dev_key, "testplanid" => plan_id }
    make_call("tl.getTestSuitesForTestPlan", args, "1.0b5")
  end
  alias_method :getTestSuitesForTestPlan, :test_suites_for_test_plan

  # List test suites within a test plan alphabetically.
  #
  # @since API version 1.0
  # @param [String] plan_id ID of the plan to get suites for.
  # @return [Array<Hash>] List of all suites in plan and their associated info.
  def test_plan_platforms plan_id
    args = { "devKey" => @dev_key, "testplanid" => plan_id }
    make_call("tl.getTestPlanPlatforms", args, "1.0")
  end
  alias_method :getTestPlanPlatforms, :test_plan_platforms

  # Gets a list of test suites that are direct children of the given test suite.
  #
  # @since API version 1.0
  # @param [String] suite_id ID of the suite to get suites for.
  # @return [Array<Hash>] List of all suites in plan and their associated info.
  def test_suites_for_test_suite suite_id
    args = { "devKey" => @dev_key, "testsuiteid" => suite_id }
    make_call("tl.getTestSuitesForTestSuite", args, "1.0")
  end
  alias_method :getTestSuitesForTestSuite, :test_suites_for_test_suite

  # Gets the set of test suites from the top level of the test project tree.
  #
  # @param [String] project_id ID of the project to get suites for.
  # @return [Array<Hash>] List of first level suites in project and their
  #   associated info.
  def first_level_test_suites_for_test_project project_id
    args = { "devKey" => @dev_key, "testprojectid" => project_id }
    make_call("tl.getFirstLevelTestSuitesForTestProject", args, "1.0b5")
  end
  alias_method :getFirstLevelTestSuitesForTestProject,
      :first_level_test_suites_for_test_project

  # Info about test cases within a test plan.
  #
  # @param [String] plan_id ID of the plan to get test cases for.
  # @param [Hash] options
  # @option options [Fixnum] testcaseid
  # @option options [Fixnum] buildid
  # @option options [Fixnum] keywordid (mutually exclusive with keywords)
  # @option options [Fixnum] keywords (mutually exclusive with keywordid)
  #   (TestLink API >=1.0)
  # @option options [String] executed
  # @option options [String] assignedto
  # @option options [String] executestatus
  # @option options [String] executiontype
  # @option options [String] getstepinfo Defaults to false
  # @return [Hash<Array>] List of all test cases in the plan and their
  #   associated info. The first element in the Array is the test case ID, the
  #   second element is the test case info.
  def test_cases_for_test_plan(plan_id, options={})
    args = { "devKey" => @dev_key, "testplanid" => plan_id }
    args.merge! options
    make_call("tl.getTestCasesForTestPlan", args, "1.0b5")
  end
  alias_method :getTestCasesForTestPlan, :test_cases_for_test_plan

  # @param [Fixnum] suite_id ID of the suite to retrieve test cases for.
  # @param [Fixnum] project_id
  # @param [Hash] options
  # @option options [Boolean] deep
  # @option options [String] details Default is "simple"; use "full" to get
  #   summary, steps & expected results.
  # @return [Array<Hash>] List of test cases in the given suite and their
  #   associated info.
  def test_cases_for_test_suite(suite_id, project_id, deep=true, details="")
    args = { "devKey" => @dev_key, "testsuiteid" => suite_id,
        "projectid" => project_id, "deep" => deep, "details" => details }
    make_call("tl.getTestCasesForTestSuite", args, "1.0b5")
  end
  alias_method :getTestCasesForTestSuite, :test_cases_for_test_suite

  # Gets the summarized results grouped by platform.
  #
  # @since TestLink API version 1.0
  # @param [Fixnum] plan_id
  # @return [Hash] Contains "type" => platform, "total_tc" => X, "details =>
  #   Array of counts.
  def totals_for_test_plan plan_id
    args = { "devKey" => @dev_key, "testplanid" => plan_id }
    make_call("tl.getTotalsForTestPlan", args, "1.0")
  end
  alias_method :getTotalsForTestPlan, :totals_for_test_plan

  # Gets attachments for specified test case.
  #
  # @param [Hash] options
  # @param [Fixnum] testcaseid If not present, testcaseexternalid must be called.
  # @param [Fixnum] testcaseexternalid If not present, testcaseid must be called.
  # @return [String]
  def test_case_attachments(options)
    args = { "devKey" => @dev_key }
    args.merge! options
    make_call("tl.getTestCaseAttachments", args, "1.0b5")
  end
  alias_method :getTestCaseAttachments, :test_case_attachments

  # @param [Fixnum] test_case_external_id
  # @param [Fixnum] project_id
  # @param [Fixnum] custom_field_name
  # @param [Hash] options
  # @option options [String] details Changes output information. If null or 'value',
  #   returns just a value; if 'full', returns a hash with all custom field definition,
  #   plus value and internal test case id; if 'simple', returns value plus custom
  #   field name, label, and type (as code).
  #   @return [Array<Hash>]
  def test_case_custom_field_design_value(test_case_external_id, project_id,
      custom_field_name, options={})
    args = { "devKey" => @dev_key, "testprojectid" => project_id,
        "testcaseexternalid" => test_case_external_id,
        "customfieldname" => custom_field_name }
    args.merge! options
    make_call("tl.getTestCaseCustomFieldDesignValue", args, "1.0b5")
  end
  alias_method :getTestCaseCustomFieldDesignValue, :test_case_custom_field_design_value

  # Info about test case by name.
  # CAUTION: returns multiple values if test case is used more than once.
  #
  # @param [String] test_case_name Name to search across TL DB.
  # @param [Hash] options
  # @option options [String] testprojectname
  # @option options [String] testsuitename
  # @option options [String] testcasepathname
  # @raise [TestLinkClient::Error] When test case name doesn't exist.
  # @return [Array<Hash>] List of all test cases in the DB matching
  #   test_case_name and their associated info.
  def test_case_id_by_name(test_case_name, options={})
    args   = { "devKey" => @dev_key, "testcasename" => test_case_name }
    args.merge! options
    make_call("tl.getTestCaseIDByName", args, "1.0b5")
  end
  alias_method :getTestCaseIDByName, :test_case_id_by_name

  # @param [Fixnum] plan_id
  # @param [Fixnum] test_case_id
  # @param [Fixnum] build_id
  # @return
  def last_execution_result(plan_id, test_case_id, build_id)
    args = { "devKey" => @dev_key, "testplanid" => plan_id,
        "testcaseid" => test_case_id, "buildid" => build_id }
    make_call("tl.getLastExecutionResult", args, "1.0b5")
  end
  alias_method :getLastExecutionResult, :last_execution_result

  # Gets a list of builds within a test plan.
  #
  # @param [String] plan_id ID of the plan to get builds for.
  # @return [Array<Hash>] List of all builds for the plan and their associated
  #   info.
  def builds_for_test_plan plan_id
    args = { "devKey" => @dev_key, "testplanid" => plan_id }
    make_call("tl.getBuildsForTestPlan", args, "1.0b5")
  end
  alias_method :getBuildsForTestPlan, :builds_for_test_plan

  # @param [String] plan_id ID of the plan to get build for.
  # @return [Hash] Info for the latest build for the given test plan.
  def latest_build_for_test_plan plan_id
    args = { "devKey" => @dev_key, "testplanid" => plan_id }
    make_call("tl.getLatestBuildForTestPlan", args, "1.0b5")
  end
  alias_method :getLatestBuildForTestPlan, :latest_build_for_test_plan

  # @param [String] project_name
  # @param [String] test_case_prefix
  # @param [Hash] options
  # @option options [String] notes
  # @option options [Hash] options ALL int treated as boolean:
  #   requirementsEnabled, testPriorityEnabled, automationEnabled,
  #   inventoryEnabled
  # @option options [Fixnum] active
  # @option options [Fixnum] public
  # @return
  def create_test_project(project_name, test_case_prefix, options={})
    args = { "devKey" => @dev_key, "testprojectname" => project_name,
        "testcaseprefix" => test_case_prefix, "notes" => notes }
    args.merge! options
    make_call("tl.createTestProject", args, "1.0b5")
  end
  alias_method :createTestProject, :create_test_project

  # @since TestLink API version 1.0
  # @param [String] plan_name
  # @param [String] project_name
  # @param [Hash] options
  # @option options [String] notes
  # @option options [String] active Defaults to 1.
  # @option options [String] public Defaults to 1.
  # @return
  def create_test_plan(plan_name, project_name, options={})
    args = { 'devKey' => @dev_key, 'testplanname' => plan_name,
        'testprojectname' => project_name, 'buildnotes' => build_notes }
    args.merge! options
    make_call('tl.createTestPlan', args, "1.0")
  end
  alias_method :createTestPlan, :create_test_plan

  # @param [String] project_id
  # @param [String] suite_name
  # @param [String] details
  # @param [Hash] options
  # @option options [String] parentid Defaults to top level.
  # @option options [Fixnum] order Order inside parent container.
  # @option options [Boolean] checkduplicatedname Check if there siblings with
  #   the same name. Defaults to true.
  # @option options [Boolean] actiononduplicatedname Applicable only if
  #   checkduplicatedname = true.
  # @return [Array<Hash>] Info about results of test suite creation.
  def create_test_suite(project_id, suite_name, details='', options={})
    args = { 'devKey' => @dev_key, 'testprojectid' => project_id,
        'testsuitename' => suite_name, 'details' => details }
    args.merge! options
    make_call('tl.createTestSuite', args, "1.0b5")
  end
  alias_method :createTestSuite, :create_test_suite

  # Creates a new build for a specific test plan.
  #
  # @param [String] plan_id
  # @param [String] build_name
  # @param [String] build_notes
  # @return
  def create_build(plan_id, build_name, build_notes='')
    args = { "devKey" => @dev_key, "testplanid" => plan_id,
       "buildname" => build_name, "buildnotes" => build_notes }
    make_call("tl.createBuild", args, "1.0b5")
  end
  alias_method :createBuild, :create_build

  # @param [String] login
  # @param [Fixnum] project_id
  # @param [Fixnum] suite_id
  # @param [String] test_case_name
  # @param [String] test_case_summary
  # @param [String] test_case_steps
  # @param [String] test_case_expected_results
  # @param [Hash] options
  # @option options [String] preconditions
  # @option options [String] execution
  # @option options [Fixnum] order
  # @option options [Fixnum] internalid
  # @option options [Boolean] checkduplicatedname
  # @option options [String] actiononduplicatedname
  # @option options [String] executiontype
  # @return
  def create_test_case(test_case_name, suite_id, project_id, login,
      test_case_summary, test_case_steps, test_case_expected_results, options={})
    args = { "devKey" => @dev_key,
        "testcasename" => test_case_name,
        "testsuiteid" => suite_id,
        "testprojectid" => project_id,
        "authorlogin" => login,
        "summary" => test_case_summary,
        "steps" => test_case_steps,
        "expectedresults" => test_case_expected_results }
    args.merge! options
    make_call("tl.createTestCase", args, "1.0b5")
  end
  alias_method :createTestCase, :create_test_case

  # Adds a test case version to a test plan.
  #
  # @param [String] project_id
  # @param [String] plan_id
  # @param [String] test_case_id
  # @param [String] test_case_version
  # @param [Hash] options Optional parameters for the method.
  # @option options [String] urgency
  # @option options [Fixnum] executionorder
  # @option options [Fixnum] platformid Only if test plan has no platforms.
  #   (TestLink API >=1.0)
  # @return
  def add_test_case_to_test_plan(project_id, plan_id, test_case_external_id,
      test_case_version, options={})
    args = { "devKey" => @dev_key, "testprojectid" => project_id,
        "testplanid" => plan_id, "testcaseexternalid" => test_case_external_id,
        "version" => test_case_version }
    args.merge! options
    make_call("tl.addTestCaseToTestPlan", args, "1.0b5")
  end
  alias_method :addTestCaseToTestPlan, :add_test_case_to_test_plan

  # Makes the call to the server with the given arguments.  Note that this also
  # allows for calling XMLRPC methods on the server that haven't yet been
  # implemented as Ruby methods here.
  #
  # @example Call a new method
  #   result = make_call("tl.getWidgets", { "testplanid" => 123 }, "1.5")
  #   raise TestLinkClient::Error, result["message"] if result["code"]
  #   return result
  # @param [String] method_name The XMLRPC method to call.
  # @param [Hash] arguments The arguments to send to the server.
  # @param [String] api_version The version of the API the method was added.
  # @return The return type depends on the method call.
  def make_call(method_name, arguments, api_version)
    ensure_version_is :greater_than_or_equal_to, api_version
    response = @server.call(method_name, arguments)

    if @version.nil?
      return response
    elsif response.is_a?(Array) && response.first['code']
      raise TestLinkClient::Error, "#{response.first['code']}: #{response.first['message']}"
    end

    response
  end

  # Sets result in TestLink by test case ID and test plan ID.
  # NOTE: will guess at last build, needs to be set to guarantee accuracy.
  # NOTE: Renamed to setTestCaseExecutionResult in version 1.0.
  #
  # @see #test_case_execution_result=
  # @version TestLink API version 1.0 Beta 5
  # @param [String] test_case_id ID of the test case to post results to.
  # @param [String] plan_id ID of the test plan to post results to.
  # @param [String] status 'p', 'f', 's', or 'b' for Pass/Fail/Skip/Block
  # @param [Hash] options
  # @option options [Fixnum] buildid ID of the build to post results to.
  # @option options [Fixnum] buildname Name of the build to post results to.
  # @option options [Fixnum] bugid ID of the bug to link results to.
  # @option options [Boolean] guess Defines whether to guess optional params
  #   or require them explicitly.  Defaults to true.
  # @option options [String] platformid ID of the platform to associate with the
  #   result. (TestLink API >=1.0)
  # @option options [String] customfields i.e. "NAME: Steve Loveless\n"
  #   (TestLink API >=1.0)
  # @option options [String] notes ?
  # @return [Hash] "status" of posting, "id" of the execution, "message"
  #   giving success or failure info.
  # @raise [TestLinkClient::Error] If result fails to be posted for any reason.
  def report_test_case_result(test_case_id, plan_id, status, options={})
    if @version >= "1.0"
      message = "Method not supported in version #{@version}. "
      message << "Use #test_case_execution_result="
      raise TestLinkClient::Error, message
    end

    args = { "devKey" => @dev_key, "testcaseid" => test_case_id,
        "testplanid" => plan_id, "status" => status, "guess" => true }
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
  # @since TestLink API version 1.0
  # @param [String] test_case_id ID of the test case to post results to.
  # @param [String] plan_id ID of the test plan to post results to.
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
  #   giving success or failure info.
  # @raise [TestLinkClient::Error] If result fails to be posted for any reason.
  def test_case_execution_result=(test_case_id, plan_id, status, options={})
    if @version < "1.0"
      message = "Method not supported in version #{@version}. "
      message << "Use #report_test_case_result"
      raise TestLinkClient::Error, message
    end

    args = { "devKey" => @dev_key, "testcaseid" => test_case_id,
        "testplanid" => plan_id, "status" => status, "guess" => true }
    args.merge! options
    result = @server.call("tl.setTestCaseExecutionResult", args).first

    unless result['message'] == 'Success!'
      raise TestLinkClient::Error, "#{result['code']}: #{result['message']}"
    end

    result
  end
  alias_method :setTestCaseExecutionResult, :test_case_execution_result=

  private

  # Raises if the version set in @version doesn't meet the comparison with the
  # passed-in version.  Returns nil if @version isn't set, since there's
  # nothing to do (and something might have called to set @version).
  #
  # @private
  # @param [Symbol] comparison
  # @param [String] version
  def ensure_version_is(comparison, version)
    message = "Method not supported in version #{@version}."

    if @version.nil?
      return
    elsif comparison == :less_than && @version >= version
      raise TestLinkClient::Error, message
    elsif comparison == :greater_than_or_equal_to && @version < version
      raise TestLinkClient::Error, message
    end
  end
end
