require 'xmlrpc/parser'

#require 'nokgiri'
=begin
module XMLRPC::XMLParser
  class NokogiriStreamParser < AbstractStreamParser
    def initialize
      @parser_class = StreamListener
    end

    class StreamListener
      include StreamParserMixin

      def method_missing *args
        # ignore
      end

      def parse(str)
        Nokogiri::XML.parse(str)
      end
    end
  end
end

require 'xmlrpc/client'

class XMLRPC::Client
  Encoding.default_internal = Encoding::UTF_8

  def self.set_debug(new_logger=nil)
    if new_logger
      @http.set_debug_output(new_logger);
    else
      @http.set_debug_output($stderr);
    end
  end
=end
=begin
  def call2(method, *args)
    request = create().methodCall(method, *args)
    data = do_rpc(request, false)
    #response = MethodResponse.from_xml(data)
    #response = MethodResponse.parse(data)
    #puts response.inspect
    #[true, response]

    #parser().parseMethodResponse(data)

    #doc = Nokogiri::XML(data)
    #[true, doc.root.to_s]

    #doc = Crack::XML.parse(data)
    #[true, doc]

    doc = MethodResponse

  end
end
=end

