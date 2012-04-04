require_relative 'wrappable/version.rb'

module Wrappable
  def app
    @app ||= App.new
  end

  def method_missing(name, *args, &blk)
    app.send(name, *args, &blk)
  end

  class App
    attr_reader :nodes

    def initialize
      @nodes = []
    end

    def endpoint(url=nil)
      @endpoint = url if url
      @endpoint
    end

    def node(name)
      current_node = Node.new(name, nil)
      @nodes << current_node
    end
  end

  class Node
    attr_reader :name

    def initialize(name, parent)
      @name = name
      @parent = parent
    end
  end
end
