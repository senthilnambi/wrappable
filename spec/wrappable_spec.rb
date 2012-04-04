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
end

describe App do
  subject do
    Module.new do
      extend Wrappable

      endpoint 'google'

      node :calendars
    end
  end

  it 'allows endpoint getters/setters' do
    subject.endpoint.should == 'google'
  end

  it 'allows defining of RESTful nodes' do
    subject.nodes.count.should == 1
  end

  it 'defines getter for node' do
    subject.calendars.should be_a(Node)
  end

  context 'when nested' do
    subject do
      Module.new do
        extend Wrappable

        node :calendars do
          node :acl
        end
        node :events
      end
    end

    it 'allows nesting of nodes' do
      subject.nodes.count.should == 3
    end

    it 'remembers parent node' do
      acl = find_node(subject.nodes, :acl)
      cal = find_node(subject.nodes, :calendars)

      acl.parent.should == cal
    end

    it 'does not affect non-nested nodes' do
      events = find_node(subject.nodes, :events)
      events.parent.should == nil
    end
  end

  def find_node(nodes, name)
    nodes.find { |node| node.name == name }
  end
end
end
