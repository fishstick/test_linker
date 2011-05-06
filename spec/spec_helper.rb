if RUBY_VERSION > '1.9'
  require 'simplecov'

  SimpleCov.start do
    add_group "Library", "lib/"
  end
end

begin
  Bundler.setup
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems."
  exit e.status_code
end

require 'rspec'
require 'fakeweb'
require File.expand_path(File.dirname(__FILE__) + '/../lib/test_linker')

def register_body(body)
  FakeWeb.register_uri(:post, 'http://testing/lib/api/xmlrpc.php',
      :content_type => 'text/xml', :body => body )
end
