require File.expand_path(File.dirname(__FILE__) + '/test_link_client/wrapper')
require File.expand_path(File.dirname(__FILE__) + '/test_link_client/version')
require File.expand_path(File.dirname(__FILE__) + '/test_link_client/error')
require File.expand_path(File.dirname(__FILE__) + '/test_link_client/helpers')
require 'xmlrpc/client'
require 'rubygems'
require 'versionomy'
require 'logger'

# TODO: Check parameter order; make sure most relevant is first.
class TestLinkClient
  include TestLinkClient::Wrapper
  include TestLinkClient::Helpers

  attr_writer :log
  attr_writer :logger
  attr_writer :log_level

  # Default value for timing out after not receiving an XMLRPC response from
  #   the server.
  DEFAULT_TIMEOUT = 30

  # Path the the XMLRPC interface (via the xmlrpc.php file) on the server.
  DEFAULT_API_PATH = "/lib/api/xmlrpc.php"

  # @param [String] server_url URL to access TestLink API
  # @param [String] dev_key User key to access TestLink API
  # @param [Hash] options
  # @option options [String] api_path Alternate path to the xmlrpc.php file on
  #   the server.
  # @option options [Fixnum] timeout Seconds to timeout after not receiving a
  #   response from the server.
  # @option options [String] version Force a different API version.
  def initialize(server_url, dev_key, options={})
    api_path = options[:api_path] || DEFAULT_API_PATH
    timeout = options[:timeout] || DEFAULT_TIMEOUT
    @dev_key = dev_key
    server_url = server_url + api_path
    @server  = XMLRPC::Client.new_from_uri(server_url, nil, timeout)
    @version = Versionomy.parse(options[:version] || api_version)
  end

  # Makes the call to the server with the given arguments.  Note that this also
  # allows for calling XMLRPC methods on the server that haven't yet been
  # implemented as Ruby methods here.
  #
  # @example Call a new method
  #   result = make_call("tl.getWidgets", { "testplanid" => 123 }, "1.5")
  #   raise TestLinkClient::Error, result["message"] if result["code"]
  #   return result
  # @param [String] method_name The XMLRPC method to call.
  # @param [Hash] arguments The arguments to send to the server.
  # @param [String] api_version The version of the API the method was added.
  # @return The return type depends on the method call.
  def make_call(method_name, arguments, api_version)
    ensure_version_is :greater_than_or_equal_to, api_version
    log "API Version: #{api_version}"
    log "Calling method: '#{method_name}' with args '#{arguments}"
    response = @server.call(method_name, arguments)
    log "Received response:"
    log response

    if @version.nil?
      return response
    elsif response.is_a?(Array) && response.first['code']
      raise TestLinkClient::Error, "#{response.first['code']}: #{response.first['message']}"
    end

    response
  end

  # @return [Boolean] Returns if logging is enabled or not.
  def log?
    @log != false
  end

  # @return [Logger,?] Returns a Logger unless you use a different type of
  #   logging object.
  def logger
    @logger ||= Logger.new STDOUT
  end

  # @return [Symbol] The method name to send to the logging object in order to
  #   log messages.
  def log_level
    @log_level ||= :debug
  end

  # @param [String] message The string to log.
  def log message
    logger.send(log_level, message) if log?
  end

  private

  # Raises if the version set in @version doesn't meet the comparison with the
  # passed-in version.  Returns nil if @version isn't set, since there's
  # nothing to do (and something might have called to set @version).
  #
  # @private
  # @param [Symbol] comparison
  # @param [String] version
  def ensure_version_is(comparison, version)
    message = "Method not supported in version #{@version}."

    if @version.nil?
      return
    elsif comparison == :less_than && @version >= version
      raise TestLinkClient::Error, message
    elsif comparison == :greater_than_or_equal_to && @version < version
      raise TestLinkClient::Error, message
    end
  end
end
