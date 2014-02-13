require 'simplecov'
require 'rspec'
require 'webtrends'
require 'coveralls'
require 'ostruct'
Coveralls.wear!

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]