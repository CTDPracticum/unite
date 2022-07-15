require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: "Jack Smith", email: "jsmith@sample.com", password: "12345678") }
  it "is not valid without a name" do
    subject.name=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without an email" do
    subject.email=nil
    expect(subject).to_not be_valid
  end
  it "is not valid if the email address doesn't have a @" do
    subject.email=nil
    expect(subject).to_not be_valid
  end
  it "is not valid if the password is less than 6 characters" do
    subject.password=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a password" do
    subject.password=nil
    expect(subject).to_not be_valid
  end
  it "returns the correct name" do
    expect(subject.name).to eq("Jack Smith")
  end
end
