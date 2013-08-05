require 'spec_helper'

describe Request do
  it { should belong_to :sender }
  it { should belong_to :availability }
end