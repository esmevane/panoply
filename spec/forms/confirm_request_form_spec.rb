require 'spec_helper'

describe ConfirmRequestForm do
  it_behaves_like "a request form"

  let(:arguments) do
    { user: user,
      params: params,
      session: Hash.new,
      controller: DummyController.new }
  end

  let(:user) { Fabricate :user }
  let(:slot_id) { 1 }
  let(:password) { "changeme" }
  let(:form) { described_class.new arguments }

  let(:params) do
    { password: password, slot_id: slot_id }
  end

  subject { form }

  it { should validate_presence_of :password }
  it { should validate_presence_of :slot_id }

  describe '#submit' do
    context 'when #valid? is true' do
      before { form.stub(:valid?) { true } }

      let(:request_attributes) do
        { sender: user, availability_id: slot_id }
      end

      it "creates a new record" do
        Request.should_receive(:create).with request_attributes
        form.submit
      end

    end
  end

  context 'with the wrong password' do
    let(:password) { "wrong password" }

    describe '#valid?' do
      subject { form.valid? }
      it { should be_false }
    end

    describe 'error messages' do
      subject do
        form.valid?
        form.errors.full_messages
      end
      it { should include "Password is invalid" }
    end

  end

end