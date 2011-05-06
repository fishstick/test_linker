require 'simplecov'
SimpleCov.start do
  add_group "Library", "lib/"
end

require File.expand_path(File.dirname(__FILE__) + '/../../lib/test_linker')
