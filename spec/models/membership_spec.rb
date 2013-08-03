require 'spec_helper'

describe Membership do
  it { should belong_to(:user) }
  it { should belong_to(:tenant) }

  describe '.make' do
    let(:user) { Fabricate :user }
    let(:tenant) { Fabricate :tenant }
    it "joins a user and tenant" do
      Membership.make user, tenant
      user.tenancies.should include tenant
    end
  end

end
