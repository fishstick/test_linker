module TestLinkClient::Helpers
  def test_project_id_for test_project_name
    project = projects.find { |project| project["name"] == test_project_name }
    project["id"]
  end

  # @return [Array] An array of test plans that match the Regexp.
  def find_test_plans test_project_id, regex
    list = []

    test_plan_list = project_test_plans(test_project_id).first

    test_plan_list.each_value do |test_plan_info|
      if test_plan_info["name"] =~ regex
        list << test_plan_info
      end
    end

    list
  end

  def api_version
    about =~ /Testlink API Version: (.+) initially/
    $1
  end
end
