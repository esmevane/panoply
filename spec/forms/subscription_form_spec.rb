require 'spec_helper'

describe SubscriptionForm do

  let(:params) { Hash.new }
  let(:session) { Hash.new }

  let(:arguments) do
    { params: params,
      session: session,
      controller: DummyController.new }
  end

  let(:form) { described_class.new arguments }

  let(:params) do
    { name: "Talina Woods",
      email: "twoods@example.com",
      password: "changeme",
      password_confirmation: "changeme",
      organization_name: 'Fiddlehead Fern',
      stripe_token: 'tok_2UlzFErnLmQkz4' }
  end

  subject { form }

  it { should respond_to :email }
  it { should respond_to :name }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :stripe_token }

  describe '#persisted?' do
    subject { form.persisted? }
    it { should be_false }
  end

  describe '#submit' do

    context 'when #valid? is true' do
      before { form.stub(:valid?) { true } }

      let(:service) { OpenStruct.new perform: true }

      let(:service_params) do
        { card_token: params[:stripe_token],
          tenant_name: params[:organization_name],
          controller: an_instance_of(DummyController),
          owner: form.user }
      end

      it "invokes #persist!" do
        described_class.any_instance.should_receive(:persist!)
        form.submit
      end

      it "creates a new user" do
        CustomerSubscriptionService.stub(:new).and_return(service)
        expect { form.submit }.to change { User.count }
      end

      it "creates a customer subscription" do
        CustomerSubscriptionService.should_receive(:new).
          with(service_params).and_return(service)
        form.submit
      end

    end

    context 'when #valid? is false' do
      before { form.stub(:valid?) { false } }
      subject { form.submit }
      it { should be_false }
    end

  end

end