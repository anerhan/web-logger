require "spec_helper"
describe AccessToken do
  it { should belong_to(:user) }
  it { should have_fields(:tmp_token, :token) }
  it { should have_field(:expired_at).of_type(DateTime) }

  it { should validate_presence_of(:token) }
  it { should validate_presence_of(:user_id) }

  let!(:user) { create :user }
  let!(:invalid_access_token) { build :access_token, user: user, tmp_token: '' }
  let(:access_token){create :access_token, user: user}

  describe 'Tmp token' do
    it 'be present if new record' do
      expect(invalid_access_token.valid?).to eq(false)
      invalid_access_token.tmp_token = 'TestToken'
      expect(invalid_access_token.valid?).to eq(true)
    end
  end

  describe 'reset_tmp_token!' do
    it 'works' do
      expect(access_token.tmp_token.blank?).to eq false
      access_token.reset_tmp_token!
      expect(access_token.tmp_token).to eq nil
    end
  end
end
