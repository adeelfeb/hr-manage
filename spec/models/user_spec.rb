require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid without email" do
    user = User.new(name: "John", role: :is_manager)
    expect(user).not_to be_valid
  end

  it "is invalid without name" do
    user = User.new(email: "test@example.com", role: :is_manager)
    expect(user).not_to be_valid
  end

  it "is invalid without role" do
    user = User.new(email: "test@example.com", name: "John")
    expect(user).not_to be_valid
  end
end
