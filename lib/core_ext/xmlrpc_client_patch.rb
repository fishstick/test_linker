require 'nokogiri'
require 'xmlrpc/client'

class XMLRPC::Client
  def self.set_debug(new_logger=nil)
    if new_logger
      @http.set_debug_output(new_logger);
    else
      @http.set_debug_output($stderr);
    end
  end

  def call2(method, *args)
    request = create().methodCall(method, *args)
    data = do_rpc(request, false)
    #response = MethodResponse.from_xml(data)
    #response = MethodResponse.parse(data)
    #puts response.inspect
    #[true, response]
    #parser().parseMethodResponse(data)
    doc = Nokogiri::XML(data)
    [true, doc.root.to_s]
  end
end
