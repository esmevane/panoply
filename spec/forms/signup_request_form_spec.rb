require 'spec_helper'

describe SignupRequestForm do

  let(:session) { Hash.new }
  let(:slot) { Fabricate :availability, provider: Fabricate(:user) }
  let(:slot_id) { slot.id }
  let(:form) { SignupRequestForm.new params, session }

  let(:params) do
    { name: "Talina Woods",
      email: "twoods@example.com",
      password: "changeme",
      password_confirmation: "changeme",
      slot_id: slot_id }
  end

  subject { form }

  describe '.model_name' do
    subject { SignupRequestForm.model_name }
    it { should == RequestForm.model_name }
  end

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