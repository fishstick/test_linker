require 'xmlrpc/client'

class XMLRPC::Client
  def set_debug(new_logger=$stderr)
    @http.set_debug_output(new_logger)
  end
end
