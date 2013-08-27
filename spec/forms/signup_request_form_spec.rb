require 'spec_helper'

describe SignupRequestForm do
  it_behaves_like "a request form"

  let(:arguments) do
    { user: nil,
      params: params,
      session: session,
      controller: DummyController.new }
  end

  let(:session) { Hash.new }
  let(:slot) { Fabricate :availability, provider: Fabricate(:user) }
  let(:slot_id) { 1 }
  let(:form) { described_class.new arguments }

  let(:params) do
    { name: "Talina Woods",
      email: "twoods@example.com",
      password: "changeme",
      password_confirmation: "changeme",
      slot_id: slot_id }
  end

  subject { form }

  describe '#submit' do
    context 'when #valid? is true' do
      before { form.stub(:valid?) { true } }

      it "creates a new user" do
        expect { form.submit }.to change { User.count }
      end

      it "creates a new record" do
        Request.should_receive(:create)
        form.submit
      end

    end
  end

end