require 'spec_helper'
require 'wrappable'

module Wrappable; describe Wrappable do
  subject do
    Module.new do
      extend Wrappable

      node :calendars
    end
  end

  it 'delegates methods to App' do
    Wrappable::App.any_instance.should_receive(:node)
    subject
  end

  it 'delegates constants to App'
end

describe App do
  subject do
    mod = Module.new do
      extend Wrappable

      endpoint 'google'
      node :calendars
    end
  end

  it 'allows endpoint getters/setters' do
    subject.endpoint.should == 'google'
  end

  it 'sets constant to newly created node' do
    Calendars.should be_a(Node)
  end
end
end
