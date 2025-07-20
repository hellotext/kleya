module Kleya
  class Error < StandardError; end
  class TimeoutError < Error; end
  class NavigationError < Error; end
  class JavaScriptError < Error; end
end
