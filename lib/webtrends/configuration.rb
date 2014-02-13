module Webtrends

  attr_accessor :configuration

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_accessor :verbose, :format, :protocol, :domain, :version, :customer_id, :event_service

    def initialize
      self.verbose = false
      self.format = 'xml'
      self.protocol = 'https'
      self.domain = 'dc.webtrends.com'
      self.version = 'v1'
      self.event_service = 'events.svc'
    end
  end
end