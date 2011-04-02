require 'rubygems'
require 'rake'

begin
  gem 'ore-tasks', '~> 0.4'
  require 'ore/tasks'

  Ore::Tasks.new
rescue LoadError => e
  STDERR.puts e.message
  STDERR.puts "Run `gem install ore-tasks` to install 'ore/tasks'."
end
begin
  require 'bundler'
rescue LoadError => e
  STDERR.puts e.message
  STDERR.puts "Run `gem install bundler` to install Bundler."
  exit e.status_code
end

begin
  Bundler.setup(:development)
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems."
  exit e.status_code
end

begin
  gem 'rspec', '~> 2.5'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new
  task :test => :spec
  task :default => :spec
rescue LoadError => e
  task :spec do
    abort "Please run `gem install rspec` to install RSpec."
  end
end

require 'ore/specification'
require 'jeweler'
Jeweler::Tasks.new(Ore::Specification.new)

require 'yard'
YARD::Rake::YardocTask.new do |t|
  t.files   = ['features/**/*.feature', 'features/**/*.rb']
  #t.options = ['--any', '--extra', '--opts'] # optional
end
task :doc => :yard

