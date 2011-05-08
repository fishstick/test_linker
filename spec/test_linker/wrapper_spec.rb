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
  
  describe "#projects" do
    it "gets a list of projects on the server" do
      body = <<-XML
<methodResponse>
  <params>
    <param>
      <value>
<array><data>
  <value><struct>
  <member><name>id</name><value><string>335241</string></value></member>
  <member><name>notes</name><value><string></string></value></member>
  <member><name>color</name><value><string></string></value></member>
  <member><name>active</name><value><string>1</string></value></member>
  <member><name>option_reqs</name><value><string>0</string></value></member>
  <member><name>option_priority</name><value><string>0</string></value></member>
  <member><name>prefix</name><value><string>W_UDI</string></value></member>
  <member><name>tc_counter</name><value><string>0</string></value></member>
  <member><name>option_automation</name><value><string>0</string></value></member>
  <member><name>name</name><value><string>Warehouse - UDI5000</string></value></member>
</struct></value>
  <value><struct>
  <member><name>id</name><value><string>465934</string></value></member>
  <member><name>notes</name><value><string></string></value></member>
  <member><name>color</name><value><string></string></value></member>
  <member><name>active</name><value><string>1</string></value></member>
  <member><name>option_reqs</name><value><string>1</string></value></member>
  <member><name>option_priority</name><value><string>1</string></value></member>
  <member><name>prefix</name><value><string>ztest</string></value></member>
  <member><name>tc_counter</name><value><string>142</string></value></member>
  <member><name>option_automation</name><value><string>1</string></value></member>
  <member><name>name</name><value><string>z_test</string></value></member>
</struct></value>
</data></array>
      </value>
    </param>
  </params>
</methodResponse>

      XML
      
      register_body(body)
      @tl.projects.should == [
          {"id"=>"335241", "notes"=>"", "color"=>"", "active"=>"1", "option_reqs"=>"0", "option_priority"=>"0", "prefix"=>"W_UDI", "tc_counter"=>"0", "option_automation"=>"0", "name"=>"Warehouse - UDI5000"}, 
          {"id"=>"465934", "notes"=>"", "color"=>"", "active"=>"1", "option_reqs"=>"1", "option_priority"=>"1", "prefix"=>"ztest", "tc_counter"=>"142", "option_automation"=>"1", "name"=>"z_test"}
        ]
    end
  end
end
