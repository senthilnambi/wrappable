require_relative 'wrappable/version'
require_relative 'wrappable/finder'
require_relative 'wrappable/node'
require_relative 'wrappable/app'

module Wrappable
  def app
    @app ||= App.new
  end

  def method_missing(name, *args, &blk)
    app.send(name, *args, &blk)
  end
end
