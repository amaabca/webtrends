module Webtrends
  class Visitor < Service

    def initialize(args = {})
      super
      self.service = args.fetch(:service, Webtrends.configuration.visitor_service)
    end

    def track
      RestClient.post endpoint, options
    end
  end
end