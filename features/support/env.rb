$:.unshift File.expand_path(File.dirname(__FILE__) + '../../lib')
require 'simplecov'
SimpleCov.start do
  add_group "Library", "lib/"
end
require 'test_link_client'
