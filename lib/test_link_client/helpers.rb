require 'test_link_client/error'

module TestLinkClient::Helpers
  def api_version
    about =~ /Testlink API Version: (.+) initially/
    $1
  end

  # Gets ID of project matching the given project_name.
  #
  # @param [String] project_name Name of the project to search for.
  # @return [String] ID of project matching project_name.
  # @raise [Exception] When ID cannot be found for given project_name.
  def test_project_id project_name
    project = test_project_by_name(project_name).first
    raise TestLinkClient::Error, project['message'] if project['code']

    project['id']
  end

  # Gets info about test plans within a project
  #
  # @param [String] project_name Name of the project to search for.
  # @param [String] plan_name Name of the plan to search for.
  # @return [String] ID of plan matching project_name and plan_name
  # @raise [RuntimeError] When unable to find matching project and plan names.
=begin
  def test_plan_id(project_name, plan_name)
    test_plan = test_plan_by_name(project_name, plan_name).first
    raise test_plan['message'] if test_plan['code']

    test_plan['id']
  end
=end

  # @param [Fixnum] project_id
  # @param [Regexp] regex The expression to match test plan names on.
  # @return [Array] An array of test plans that match the Regexp.
  def find_test_plans(project_id, regex)
    list = []

    test_plan_list = project_test_plans(project_id).first

    test_plan_list.each_value do |test_plan_info|
      if test_plan_info["name"] =~ regex
        list << test_plan_info
      end
    end

    list
  end

  def first_level_test_suite_id(project_name, suite_name)
    test_suites = first_level_test_suites_for_test_project(test_project_id(project_name))

    test_suites.each do |test_suite|
      if test_suite['name'] == suite_name
        return test_suite['id']
      end
    end

    raise TestLinkClient::Error, "Suite #{suite_name} not found."
  end

  # Gets info about test plans within a project
  #
  # @param [String] project_name Name of the project to search for.
  # @param [String] plan_name Name of the plan to search for.
  # @param [String] build_name Name of the build to search for.
  # @return [String] ID of plan matching project_name and plan_name
  # @raise [RuntimeError] When unable to find matching project/plan/build names.
  def build_id(project_name, plan_name, build_name)
    plan_id = test_plan_id(project_name, plan_name)
    builds = builds_for_test_plan plan_id

    builds.each do |build|
      if build['name'] == build_name
        return build['id']
      end
    end

    raise TestLinkClient::Error,
        "Unable to find build named #{build_name} for #{plan_name} in #{project_name}"
  end

  # Gets info about test case within a test plan within a project.
  #
  # @param [String] project_name Name of the project to search for.
  # @param [String] plan_name Name of the plan to search for.
  # @param [String] test_case_name Name of the test case to search for.
  # @return [Hash] Info on the first matching test case.
  # @raise [RuntimeError] When unable to find matching project/plan/test case names.
  # @todo Need to update for having more than one of same test name inside test plan.
  def test_info(project_name, plan_name, test_case_name)
    test_plan_id = test_plan_id(project_name, plan_name)
    test_cases = test_cases_for_test_plan(test_plan_id)

    test_cases.each_value do |test_case_info|
      if test_case_info['name'] == test_case_name
        return test_case_info
      end
    end

    raise TestLinkClient::Error,
        "Unable to find test named #{test_case_name} for #{plan_name} in #{project_name}"
  end

  # Gets info about test suite within a test plan within a project.
  #
  # @param [String] project_name
  # @param [String] plan_name
  # @param [String] suite_name
  # @return [String] SuiteID
  # @todo NEED TO CLEAN THIS UP AND ADD ERROR CHECKING
  # @todo Need to update for having more than one of same test name inside testplan
  def suite_info(project_name, plan_name, suite_name)
    test_plan_id = test_plan_id(project_name, plan_name)
    test_suites = test_suites_for_test_plan(test_plan_id)

    if test_suites.empty?
      return "Unable to find test suites in test plan #{plan_name} in #{project_name}"
    end

    test_suites.each do |suite|
      if suite["name"].include? suite_name
        return suite
      end
    end

    raise TestLinkClient::Error,
        "Unable to find suite named #{suite_name} for #{plan_name} in #{project_name}"
  end

  # Get the ID of a first level suite, creating it if it does not exist.
  #
  # @param [String] project_name
  # @param [String] suite_name
  # @return [String] ID of the created or existing suite.
  def create_first_level_suite(project_name, suite_name)
    return first_level_test_suite_id(project_name, suite_name)
  rescue RuntimeError

    # Create suite if it doesn't exist.
    project_id = test_project_id(project_name)

    create_test_suite(project_id, suite_name).first['id']
  end

  # Get the ID of a suite with the given parent, creating it if it does not
  # exist.
  #
  # @param [String] project_name
  # @param [String] suite_name
  # @return [String] ID of the created or existing suite.
  def create_suite(project_name, suite_name, parent_id)
    project_id = test_project_id(project_name)
    response = test_suites_for_test_suite(parent_id)

    if response.class == Array
      raise response.first['message']
    elsif response.class == Hash
      return response['id'] if response['name'] == suite_name

      response.each_value do |suite|
        return suite['id'] if suite['name'] == suite_name
      end
    end

    create_test_suite(project_id, suite_name, parent_id).
      first['id']
  end

  # Creates test in test suite within a test plan within a project.
  # @example
  #   create_test_case("jromo", test_prj_id, test_suite_id, "newTCName2","TC summary here",
  #               "1. do this 2.do that", "should pass on 2")
  #
  # @param [String] login
  # @param [String] project_name
  # @param [String] plan_name
  # @param [String] suite_name
  # @param [String] test_case_name
  # @param [String] summary
  # @param [String] steps
  # @param [String] expected_results
  # @return [Array] array->  array[0]=test case id, array[1]=test case version
  # @todo NEED TO CLEAN THIS UP AND ADD ERROR CHECKING
  # @todo do we need pln_name??  Need for suiteinfo, but is it really necessary?
  def create_test_case(login, project_name, plan_name, suite_name, test_case_name,
      summary, steps, expected_results)

    test_project_id = self.test_project_id(project_name)
    test_suite_id = self.suite_info(project_name, plan_name, suite_name)
    test_case_id = nil
    test_case_version = nil

    # @todo Need to update for having more than one of same test name inside testplan
    result = self.create_test_case(login, test_project_id, test_suite_id, test_case_name,
      summary, steps, expected_results)

    if result.any?
      #probably need more error checking.  Will return reason if fail.
      result.each do |result_ptr|
        if result_ptr["message"].eql? "Success!"
          if result_ptr.has_key? "additionalInfo"
            result_info = result_ptr.fetch("additionalInfo")
            if result_info["msg"].eql? "ok"
              test_case_id = result_info["id"]
              test_case_version = result_info["version_number"]
              return [test_case_id, test_case_version]
            else
              return -1
            end
          end
        end
      end
    end
  end

  # Creates test in test suite within a test plan within a project.
  #
  # @param [String] project_name
  # @param [String] plan_name
  # @param [String] test_case_id
  # @param [String] test_case_version
  # @return [Boolean] true on success, false on fail
  # @todo NEED TO CLEAN THIS UP AND ADD ERROR CHECKING
  # @todo Need to update for having more than one of same test name inside testplan
  def add_test_case_to_test_plan(project_name, plan_name, test_case_id,
      test_case_version)
    test_project_id = test_project_id(project_name)
    test_plan_id =  test_plan_id(project_name, plan_name)

    result = add_test_case_to_test_plan(test_project_id,
      test_plan_id, test_case_id, test_case_version)

    if result.any?
      #Only way to tell if success if with the key "feature_id"
      return result.has_key?("feature_id") ? true : false
    end
  end
end
