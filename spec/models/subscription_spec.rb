require 'spec_helper'

describe Subscription do

  it { should belong_to :owner }
  it { should have_many :tenants }
  it { should validate_presence_of :stripe_token }

  let(:subscription) { Fabricate(:subscription) }

end
