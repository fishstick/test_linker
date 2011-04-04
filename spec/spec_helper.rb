require 'simplecov'

SimpleCov.start do
  add_group "Library", "lib/"
end

require 'rspec'
$:.unshift File.expand_path(File.dirname(__FILE__) + '../lib')
require 'test_linker'
require 'test_linker/version'
