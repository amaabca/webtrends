module Webtrends
  class Event

    attr_accessor :tags, :verbose, :endpoint, :format

    def initialize(args = {})
      self.tags = args.fetch(:tags, {})
      self.verbose = args.fetch(:verbose, Webtrends.configuration.verbose)
      self.endpoint = args.fetch(:endpoint, Webtrends.configuration.endpoint)
      self.format = args.fetch(:format, Webtrends.configuration.format)
    end

    def track
      if !tags.empty?
        RestClient.post endpoint, options.merge(tags)
      end
    end

    private
      def options
        {dcsverbose: verbose, dcsformat: format}
      end
  end
end