def basic_auth_header(email, password)
  header "Authorization", "Basic #{Base64.strict_encode64("#{email}:#{password}")}"
end

def oauth_auth_header(access_token)
  header "Authorization", "OAuth #{access_token}"
end
