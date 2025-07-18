require 'rails_helper'

RSpec.describe Project, type: :model do
  it "can have many users" do
    project = create(:project)
    user1 = create(:user)
    user2 = create(:user)
    project.users << [user1, user2]
    expect(project.users.count).to eq(2)
  end

  it "can have many bugs" do
    project = create(:project)
    bug1 = create(:bug, project: project)
    bug2 = create(:bug, project: project)
    expect(project.bugs.count).to eq(2)
  end

  it "is invalid if a manager is assigned to it as a member" do
    project = create(:project)
    manager = create(:user, role: :is_manager)
    project.users << manager
    expect(project).not_to be_valid
  end
end
