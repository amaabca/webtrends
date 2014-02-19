module Webtrends
  class Service

    attr_accessor :verbose, :format, :protocol, :domain, :version, :customer_id, :service

    def initialize(args = {})
      self.verbose = args.fetch(:verbose, Webtrends.configuration.verbose)
      self.format = args.fetch(:format, Webtrends.configuration.format)
      self.protocol = args.fetch(:protocol, Webtrends.configuration.protocol)
      self.domain = args.fetch(:protocol, Webtrends.configuration.domain)
      self.version = args.fetch(:version, Webtrends.configuration.version)
      self.customer_id = args.fetch(:customer_id, Webtrends.configuration.customer_id)
    end

  private
    def options
      {dcsverbose: verbose, dcsformat: format}
    end

    def endpoint
      "#{protocol}://#{domain}/#{version}/#{customer_id}/#{service}"
    end
  end
end