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
      current_node = Node.new(name, @current_node)
      nodes << current_node

      current_node_scope(current_node) do
        yield if block_given?
      end
    end

    private

    def method_missing(name, *args, &blk)
      existing_node = find_node(name)
      existing_node ? existing_node : super
    end

    def current_node_scope(node)
      scope(:current_node, node) do
        yield
      end
    end

    def scope(name, value=nil)
      instance_variable_set("@#{name}", value)
      yield
    ensure
      instance_variable_set("@#{name}", nil)
    end

    def find_node(name)
      nodes.find {|node| node.name == name }
    end
  end

  class Node
    attr_reader :name, :parent

    def initialize(name, parent)
      @name = name
      @parent = parent
    end
  end
end
