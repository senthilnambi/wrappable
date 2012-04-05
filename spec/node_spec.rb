require 'spec_helper'

module Wrappable; describe Node do
  let(:dummy_action) { mock(:name => :dummy) }
  let(:show_action)  { mock(:name => :show)  }
  let(:parent)       { described_class.new(:parent_node, nil)}

  subject do
    described_class.new(:calendars, parent).tap do |node|
      node.actions << dummy_action << show_action
    end
  end

  it 'delegates methods to actions based on name' do
    show_action.should_receive(:run).with(calendarId)
    subject.show(calendarId)
  end

  it 'raises error if no action was found' do
    expect do
      subject.index
    end.to raise_error(NoMethodError)
  end

  it 'returns parent names' do
    subject.parent_names.should == [:parent_node, :calendars]
  end
end
end
