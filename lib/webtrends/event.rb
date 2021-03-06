module Webtrends
  class Event < Service

    attr_accessor :tags

    def initialize(args = {})
      super
      self.tags = args.fetch(:tags, {})
      self.service = args.fetch(:service, Webtrends.configuration.event_service)
    end

    def track
      if !tags.nil? && !tags.empty?
        RestClient.post endpoint, options.merge(tags)
      end
    rescue => ex
      raise Webtrends::Exception.new(ex)
    end
  end
end