require "spec_helper"

resource "Authorization /access_tokens (AccessTokensController)" do
  let(:user)              { create :user }
  let(:user_access_token) { create :access_token, user: user }

  post "/access_tokens.json" do

    let(:access_token) { { tmp_token: 'FeGeneratedToken' } }

    example "Generate access_token by tmp_token and basic auth" do
      basic_auth_header user.email, 'password'
      do_request access_token: access_token
      expect(status).to eq 201
    end

    example "Respond with 500 status and JSON error message if tmp_token doesn't exist", document: nil do
      basic_auth_header user.email, 'password'
      do_request access_token: nil
      expect(status).to eq 500
      JSON.parse(response_headers['X-ERRORS'])['tmp_token'][0].include?("can't be blank")
    end
  end

  get "/access_tokens/:id.json" do

    let(:id) { user_access_token.tmp_token }

    example "Get access_token and user_id by tmp_token" do
      do_request id: user_access_token.tmp_token
      expect(status).to eq 200
      expect(user_access_token.reload.tmp_token).to eq(nil)
      expect(parsed_body['access_token']['user_id']).to eq(user.id.to_s)
      expect(parsed_body['access_token']['token']).to eq(user_access_token.token)
    end

    example "Get access_token and user_id by invalid tmp_token", document: nil do
      do_request  id: 'invalid_tmp_token'
      expect(status).to eq 404
    end
  end
end
