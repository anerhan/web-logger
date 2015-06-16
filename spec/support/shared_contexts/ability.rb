require 'cancan/matchers'

shared_context 'simple_user_ability' do
  let(:user) { create :user }
  subject { Ability.new(user) }
  let(:collection) { described_class.base_class.accessible_by(subject).to_a }
end

shared_context 'admin_ability' do
  let(:admin) { create :admin }
  subject { Ability.new(admin) }
  let(:collection) { described_class.base_class.accessible_by(subject).to_a }
end
