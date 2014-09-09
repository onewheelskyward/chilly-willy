require 'simplecov'
SimpleCov.start

# Read 'em in and go!
Dir.glob('spec/**/*_spec.rb') { |file| require_relative file.gsub /^spec\//, '' }
