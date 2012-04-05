require_relative 'wrappable/version'
require_relative 'wrappable/finder'
require_relative 'wrappable/node'

module Wrappable
  def app
    @app ||= App.new
  end

  def method_missing(name, *args, &blk)
    app.send(name, *args, &blk)
  end

  class App
    include Finder

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

    def method_missing(name, *args, &blk)
      existing_node = find_in_array(nodes, name)
      existing_node ? existing_node : super
    end
  end
end
