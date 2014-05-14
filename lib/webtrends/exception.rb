module Webtrends
  class Exception < Exception
    def initialize(ex)
      super(ex.message)
      set_backtrace(ex.backtrace)
    end
  end
end