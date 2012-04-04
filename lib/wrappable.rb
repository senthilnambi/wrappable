require_relative 'wrappable/version.rb'

module Wrappable
  def app
    @app ||= App.new
  end

  def method_missing(name, *args, &blk)
    app.send(name, *args, &blk)
  end

  def self.const_missing(name)
    App.const_get(name)
  end

  class App
    def initialize
      @nodes = []
    end

    def endpoint(url=nil)
      @endpoint = url if url
      @endpoint
    end

    def node(name)
      current_node = Node.new
      self.class.const_set(name.to_s.capitalize, current_node)
    end
  end

  class Node
  end
end
