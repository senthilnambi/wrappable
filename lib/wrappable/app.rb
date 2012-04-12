module Wrappable
  # why have app class at all? prevents @nodes, @path etc. from
  # polluting namespace of class adding this module
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

    def access_token(token=nil)
      @access_token = token if token
      @access_token
    end

    def node(name)
      current_node = Node.new(name, @current_node)
      nodes << current_node

      current_node_scope(current_node) do
        yield if block_given?

        # belongs in node dsl, but methods should be available in app
        # move to Node? feels like top down design
        member_scope do
          get :show
          put :update
          patch :patch
          delete :delete
        end

        collection_scope do
          get :index
          post :create
        end
      end
    end

    def member_scope
      member_path = MemberPath.new(@current_node, action, ids, endpoint
                                   access_token)
      scope(:path, member_path) do
        yield
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
