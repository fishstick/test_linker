require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TestLinker::Wrapper do
  before do
    body = "<?xml version=\"1.0\"?>\n<methodResponse>\n  <params>\n    <param>\n      <value>\n        <string> Testlink API Version: 1.0 initially written by Asiel Brumfield\n with contributions by TestLink development Team</string>\n      </value>\n    </param>\n  </params>\n</methodResponse>\n"
    register_body(body)
    @tl = TestLinker.new "http://testing", "devkey"
  end
  
  after :each do
    FakeWeb.clean_registry
  end
  
  describe "#about" do
    it "gets the about string from the server" do
      @tl.about.should == " Testlink API Version: 1.0 initially written by Asiel Brumfield\n with contributions by TestLink development Team"
    end
  end
  
  describe "#say_hello" do
    it "gets the server to say 'Hello!'" do
      body = <<-XML
<?xml version=\"1.0\"?>
<methodResponse>
  <params>
    <param>
      <value>
        <string>Hello!</string>
      </value>
    </param>
  </params>
</methodResponse>

XML
      register_body(body)
      @tl.say_hello.should == "Hello!"
    end
  end
end
