require "spec_helper"
describe User do

  authenticable

  it { should belong_to(:group) }
  it { should have_fields(:first_name, :last_name, :gender, :email) }

  let!(:user)         { create :user }
  let!(:access_token) { create :access_token, user: user }

  context 'class methods' do
    describe 'oauth_auth' do
      it 'works' do
        expect(User.oauth_auth(access_token.token)).to eq(user)
      end
      it 'return nil if access_token doesn\'t exist' do
        expect(User.oauth_auth(nil)).to eq(nil)
      end
      it 'return nil if access_token is ivalid' do
        expect(User.oauth_auth('invalid_access_token')).to eq(nil)
      end
    end

    describe 'basic_auth' do
      it 'works' do
        expect(User.basic_auth(user.email, 'password')).to eq(user)
      end
      it 'return nil if email doesn\'t exist' do
        expect(User.basic_auth(nil, 'password')).to eq(nil)
      end
      it 'return nil if password doesn\'t exist' do
        expect(User.basic_auth(user.email, nil)).to eq(nil)
      end
      it 'return nil if password and email both doesn\'t exist' do
        expect(User.basic_auth(nil, nil)).to eq(nil)
      end
    end
  end

end
