require 'xmlrpc/client'

class XMLRPC::Client
  def self.set_debug(new_logger=nil)
    if new_logger
      @http.set_debug_output(new_logger)
    else
      @http.set_debug_output($stderr)
    end
  end
end
