require 'simplecov'

SimpleCov.start do
  add_group "Library", "lib/"
end

begin
  Bundler.setup
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems."
  exit e.status_code
end

require 'rspec'
require_relative '../lib/test_linker'
require_relative '../lib/test_linker/version'
