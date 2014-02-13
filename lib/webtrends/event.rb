module Webtrends
  class Event < Service

    attr_accessor :tags

    def initialize(args = {})
      super
      self.tags = args.fetch(:tags, {})
      self.service = args.fetch(:service, Webtrends.configuration.event_service)
    end

    def track
      if !tags.empty?
        RestClient.post endpoint, options.merge(tags)
      end
    end
  end
end