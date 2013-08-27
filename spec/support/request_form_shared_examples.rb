shared_examples "a request form" do

  let(:arguments) do
    { user: nil, params: params, session: session, controller: controller }
  end

  let(:controller) { DummyController.new }
  let(:email) { "twoods@example.com" }
  let(:form) { described_class.new arguments }
  let(:password) { "changeme" }
  let(:session) { Hash.new }
  let(:slot) { Fabricate :availability, provider: Fabricate(:user) }
  let(:user) { Fabricate :user, email: email, password: password }
  let(:slot_id) { slot.id }

  let(:params) do
    { email: email, password: password, slot_id: slot_id }
  end

  subject { form }

  describe '.model_name' do
    subject { described_class.model_name }
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

  describe '#initialize' do
    it "invokes #post_initialize with the given parameters" do
      described_class.any_instance.should_receive(:post_initialize).
        with arguments
      described_class.new arguments
    end
  end

  describe '#submit' do

    context 'when #valid? is true' do
      before { form.stub(:valid?) { true } }
      it "invokes #persist!" do
        described_class.any_instance.should_receive(:persist!)
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
