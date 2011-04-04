require 'simplecov'
SimpleCov.start do
  add_group "Library", "lib/"
end
require_relative '../../lib/test_linker'
