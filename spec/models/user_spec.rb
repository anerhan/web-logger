require "spec_helper"
describe User do

  authenticable

  it { should have_fields(:first_name, :last_name, :gender, :email, :position) }

  it { should validate_inclusion_of(:position).to_allow(User::POSITIONS.keys)}
  it { should validate_format_of(:email).to_allow("anerhan@mail.ru").not_to_allow(["invalid_email", 'a@a.co']) }

  let!(:user)         { create :user }
  let!(:access_token) { create :access_token, user: user }

  context 'constants' do
    describe 'POSITIONS' do
      it 'exist' do
        expect(User::POSITIONS).to eq({0 => 'user', 3 => 'admin'})
      end
    end
  end

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
