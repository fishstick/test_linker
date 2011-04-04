require 'simplecov'

SimpleCov.start do
  add_group "Library", "lib/"
end

require 'rspec'
require_relative '../lib/test_linker'
require_relative '../lib/test_linker/version'
