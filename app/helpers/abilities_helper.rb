module AbilitiesHelper

  def extract_auth_data
    Base64.strict_decode64(request_header('Authorization').split(' ').last).split(':')
  end

  def access_token
    request_header('Authorization').split(' ').last
  end

  def current_user
    if oauth_auth?
      User.oauth_auth(access_token)
    elsif basic_auth?
      email, password = extract_auth_data
      User.basic_auth(email, password)
    else
      User.first || User.new
    end
  end

  def request_header(key)
    request.env['HTTP_' + key.upcase]
  end

  def basic_auth?
    request_header('Authorization').present? && request_header('Authorization').include?('Basic')
  end

  def oauth_auth?
    request_header('Authorization').present? && request_header('Authorization').include?('OAuth')
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, request.path_info.match(/(?<=\A\/api\/v1\/)[a-z_]+/).to_s.to_sym)
  end
end
