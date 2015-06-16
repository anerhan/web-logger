require 'spec_helper'

resource User, 'ability' do
  include_context 'simple_user_ability'

  let!(:admin)        { create :admin }
  let!(:user)         { create :user }
  let!(:another_user) { create :user, email: 'another@gmail.com' }

  let!(:stage)   { create :stage, user: admin }
  let!(:project) { create :stage, user: admin }

  describe 'simple user' do
    it { is_expected.to be_able_to(:manage, User, user) }
    it { is_expected.to be_able_to(:read, User, user) }
    it { is_expected.to be_able_to(:read, Stage, user) }
    it { is_expected.to be_able_to(:read, Project, user) }
  end
end
