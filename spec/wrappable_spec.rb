require 'spec_helper'

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
end
