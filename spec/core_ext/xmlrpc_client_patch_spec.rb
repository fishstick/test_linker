require_relative '../spec_helper'

require 'core_ext/xmlrpc_client_patch'
require 'fake_web'
require 'test_xml/spec'

describe XMLRPC::Client do
  describe ".set_debug" do
    context "takes nil for its parameter" do
      pending
    end

    context "takes a Logger for its parameter" do
      pending
    end
  end

  describe "#call2" do
    before do
      @url = "http://localhost/lib/api/xmlrpc.php"
      @response = <<-XML
<methodResponse>\n
    <params>\n
        <param>\n
            <value>\n
                <string> Testlink API Version: 1.0 Beta 5 initially written by
                    Asiel Brumfield\n with contributions by TestLink development
                    Team
                </string>
                \n
            </value>
            \n
        </param>
        \n
    </params>
    \n
</methodResponse>
      XML
      FakeWeb.register_uri(:post, @url, body: @response, content_type: 'text/xml',
        status: ["200", "OK"])
    end

    it "returns a methodResponse as XML" do
      client = XMLRPC::Client.new_from_uri(@url)
      response = client.call "hi"
      response.should equal_xml @response
    end
  end
end
