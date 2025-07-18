require 'rails_helper'

RSpec.describe Bug, type: :model do
  let(:creator) { create(:user, role: :is_qa) }
  let(:developer) { create(:user, role: :is_developer) }
  let(:project) { create(:project, user: create(:user, role: :is_manager)) }

  it "is invalid without a category" do
    bug = build(:bug, bug_category: nil)
    expect(bug).not_to be_valid
  end

  it "is invalid without a progress_state" do
    bug = build(:bug, progress_state: nil)
    expect(bug).not_to be_valid
  end

  it "must belong to a user (creator)" do
    bug = build(:bug, user: nil)
    expect(bug).not_to be_valid
  end


  it "can be valid without a developer" do
    bug = build(:bug, developer: nil)
    expect(bug).to be_valid
  end

  it "must belong to a project" do
    bug = build(:bug, project: nil)
    expect(bug).not_to be_valid
  end
end
