require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'core_ext/xmlrpc_client_patch'
require 'fake_web'

describe XMLRPC::Client do
  describe ".set_debug" do
    context "takes nil for its parameter" do
      pending
    end

    context "takes a Logger for its parameter" do
      pending
    end
  end
end
