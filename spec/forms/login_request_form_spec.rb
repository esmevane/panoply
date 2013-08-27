require 'spec_helper'

describe LoginRequestForm do
  it_behaves_like "a request form"

  let(:arguments) do
    { user: user, params: params, session: session, controller: controller }
  end

  let(:controller) { DummyController.new }
  let(:email) { "twoods@example.com" }
  let(:form) { described_class.new arguments }
  let(:password) { "changeme" }
  let(:session) { Hash.new }
  let(:slot_id) { 1 }

  let(:params) do
    { email: email, password: password, slot_id: slot_id }
  end

  let(:user) do
    Fabricate :user, email: email, password: password,
      password_confirmation: password
  end

  subject { form }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

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

  context 'with the wrong password' do
    let(:wrong_password) { "wrong password" }
    before { params[:password] = wrong_password }

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