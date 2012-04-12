module Wrappable
  class Action
    include Connection

    # use attr_* always, move power in future to change them
    attr_reader :name, :verb, :path, :body, :headers

    # replication of path object, downward coupling
    # will we know body, headers at #initialize?
    def initialize(name, verb, path, body, headers)
      @name = name
      # ...
    end

    # path needs to be compiled here, since args contains ids
    def run(*args)
      connection.run_request(verb, path.compile, body, headers)
    end
  end
end
