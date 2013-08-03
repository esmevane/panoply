require 'spec_helper'

describe SubdomainConstraint do

  describe '.matches?' do

    subject { SubdomainConstraint.matches? request }

    context 'when the request has a www subdomain' do
      let(:request) { OpenStruct.new subdomain: 'www' }
      it { should be_false }
    end

    context 'when the subdomain is absent' do
      let(:request) { OpenStruct.new subdomain: nil }
      it { should be_false }
    end

    context 'when the subdomain is not www' do
      let(:request) { OpenStruct.new subdomain: 'fiddlehead-fern' }
      it { should be_true }
    end

  end

end