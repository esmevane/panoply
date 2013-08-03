require 'spec_helper'

describe Availability do

  it { should belong_to :provider }

  describe '.slot_time_for' do

    let(:attributes) do
      { provider: Fabricate(:user) }
    end

    it 'calls #create with given arguments' do
      Availability.should_receive(:create).with(attributes)
      Availability.slot_time_for(attributes)
    end

  end

end
