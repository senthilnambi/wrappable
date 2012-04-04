module Wrappable
  module Finder
    def find_in_array(array, name)
      array.find {|elem| elem.send(:name) == name }
    end
  end
end
