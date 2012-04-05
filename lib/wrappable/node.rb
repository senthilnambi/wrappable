module Wrappable
  class Node
    include Finder

    attr_reader :name, :parent, :actions

    def initialize(name, parent)
      @name = name
      @parent = parent
      @actions = []
    end

    def parent_names
      current_node = self
      array = [] << current_node.name
      while current_node.parent
        array << current_node.parent.name
        current_node = current_node.parent
      end

      array.reverse
    end

    private

    def method_missing(name, *args, &blk)
      action = find_in_array(actions, name)
      action ? action.run(*args, &blk) : super
    end
  end
end
