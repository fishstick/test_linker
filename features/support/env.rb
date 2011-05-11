if RUBY_VERSION > '1.9'
  require 'simplecov'
  
  SimpleCov.start do
    add_group "Library", "lib/"
  end
end

require File.expand_path(File.dirname(__FILE__) + '/../../lib/vatf_test_linker')
