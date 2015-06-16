require "spec_helper"
describe Stage do

  it { should have_fields(:name, :ip, :domain, :description) }

  it { should have_many :projects }
  it { should belong_to :user }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_id) }
end
