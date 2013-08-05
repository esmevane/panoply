require 'spec_helper'

describe RequestForm do

  let(:user) { Fabricate :user }
  let(:slot) { Fabricate :availability, provider: user }
  let(:slot_id) { slot.id }
  let(:password) { "changeme" }
  let(:form) { RequestForm.new user, params }

  let(:params) do
    { password: password, slot_id: slot_id }
  end

  subject { form }

  it { should validate_presence_of :password }
  it { should validate_presence_of :slot_id }

  describe '#notice' do
    let(:notice) { "Thank you!  Your appointment request has been sent" }
    subject { form.notice }
    it { should == notice }
  end

  describe '#persisted?' do
    subject { form.persisted? }
    it { should be_false }
  end

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