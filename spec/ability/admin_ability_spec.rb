require 'spec_helper'

resource User, 'ability' do
  include_context 'admin_ability'
  describe 'Admin' do
    it { is_expected.to be_able_to :manage, :all }
  end
end
