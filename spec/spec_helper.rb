require 'simplecov'

SimpleCov.start do
  add_group "Library", "lib/"
end

begin
  Bundler.setup
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems."
  exit e.status_code
end

require 'rspec'
require_relative '../lib/test_linker'
require_relative '../lib/test_linker/version'

REQUEST = Hash.new
REQUEST[:test_cases_for_test_plan] = <<-XML_REQUEST
<?xml version=\"1.0\" ?>
<methodCall>
  <methodName>tl.getTestCasesForTestPlan</methodName>
  <params>
    <param>
      <value>
        <struct>
          <member>
            <name>devKey</name>
            <value>
              <string>90b7941411928ae0a84d19f365a01a63</string>
            </value>
          </member>
          <member>
            <name>testplanid</name>
            <value>
              <string>401818</string>
            </value>
          </member>
          <member>
            <name>buildid</name>
            <value>
              <string>4868</string>
            </value>
          </member>
        </struct>
      </value>
    </param>
  </params>
</methodCall>
XML_REQUEST

RESPONSE = Hash.new
RESPONSE[:about] = <<-XML_RESPONSE
<?xml version=\"1.0\"?>
<methodResponse>
  <params>
    <param>
      <value>
        <string> Testlink API Version: 1.0 Beta 5 initially written by Asiel Brumfield\n with contributions by TestLink development Team</string>
      </value>
    </param>
  </params>
</methodResponse>
XML_RESPONSE
