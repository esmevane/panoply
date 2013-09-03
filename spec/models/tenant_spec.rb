require 'spec_helper'

describe Tenant do

  it { should have_many :memberships }
  it { should have_many(:members).through :memberships }
  it { should belong_to :subscription }

  let(:tenant) { Fabricate(:tenant, name: "Fiddlehead Fern") }

  describe '#domain' do
    subject { tenant.domain }
    it "is a parameterized version of #name" do
      expect(subject).to eq tenant.name.parameterize
    end
  end

end
