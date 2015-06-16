require "spec_helper"
describe Project do

  it { should have_fields(:name, :settings, :log_files) }

  it { should belong_to :stage }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:log_files) }
end
