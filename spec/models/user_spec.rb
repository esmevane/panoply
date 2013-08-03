require 'spec_helper'

describe User do

  it { should have_many :memberships }
  it { should have_many(:tenancies).through :memberships }
  it { should have_many(:availabilities) }

  describe "passwords" do
    let(:user) { Fabricate :user, attributes }
    subject { user }
    it { should respond_to :password }
    it { should respond_to :password_confirmation }
  end

  let(:attributes) do
    { name: "Example User",
      email: "user@example.com",
      password: "changeme",
      password_confirmation: "changeme" }
  end

  it "should create a new instance given a valid attribute" do
    User.create! attributes
  end

  describe 'email validations' do

    let(:no_email) { attributes.merge email: '' }
    let(:upcased_email) { attributes[:email].upcase }

    let(:good_addresses) do
      %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    end

    let(:bad_addresses) do
      %w[user@foo,com user_at_foo.org example.user@foo.]
    end

    it "should require an email address" do
      no_email_user = User.new no_email
      no_email_user.should_not be_valid
    end

    it "should accept valid email addresses" do
      good_addresses.each do |address|
        user = User.new attributes.merge email: address
        user.should be_valid
      end
    end

    it "should reject invalid email addresses" do
      bad_addresses.each do |address|
        user = User.new attributes.merge email: address
        user.should_not be_valid
      end
    end

    it "should reject duplicate email addresses" do
      Fabricate :user, attributes
      user = User.new attributes
      user.should_not be_valid
    end

    it "should reject email addresses identical up to case" do
      Fabricate :user, attributes.merge(email: upcased_email)
      user = User.new attributes
      user.should_not be_valid
    end
  end

  describe "password validations" do

    subject { user }

    describe 'without passwords' do
      let(:blank_passwords) do
        { password: "", password_confirmation: "" }
      end
      let(:user) { User.new attributes.merge blank_passwords }
      it { should_not be_valid }
    end

    describe 'without matching confirms' do
      let(:invalid_confirm) do
        { password_confirmation: "invalid" }
      end
      let(:user) { User.new attributes.merge invalid_confirm }
      it { should_not be_valid }
    end

    describe 'with short passwords' do
      let(:short_password) { "abcde" }
      let(:short_passwords) do
        { password: short_password, password_confirmation: short_password }
      end
      let(:user) { User.new attributes.merge short_passwords }
      it { should_not be_valid }
    end

  end

  describe "password encryption" do

    let(:user) { Fabricate :user, attributes }

    subject { user }

    it { should respond_to :encrypted_password }

    it "should set the encrypted password attribute" do
      subject.encrypted_password.should_not be_blank
    end

  end

end
