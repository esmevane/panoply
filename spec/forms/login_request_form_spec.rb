require 'spec_helper'

class DummyController
  def sign_in(key, object)
    nil
  end
end

describe LoginRequestForm do

  let(:email) { "twoods@example.com" }
  let(:password) { "changeme" }
  let(:user) { Fabricate :user, email: email, password: password }
  let(:slot) { Fabricate :availability, provider: Fabricate(:user) }
  let(:session) { Hash.new }
  let(:controller) { DummyController.new }
  let(:slot_id) { slot.id }
  let(:form) { LoginRequestForm.new nil, params, session, controller }

  let(:params) do
    { email: email, password: password, slot_id: slot_id }
  end

  subject { form }

  describe '.model_name' do
    subject { LoginRequestForm.model_name }
    it { should == "RequestForm" }
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

      it "creates a new record" do
        Request.should_receive(:create)
        form.submit
      end

      it "signs the user in" do
        form.controller.should_receive(:sign_in).with(:user, form.user)
        form.submit
      end

    end
  end

end