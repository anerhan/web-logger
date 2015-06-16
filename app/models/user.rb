class User
  include Base
  include Exts::Authenticable

  field :first_name,  type: String,   default: nil
  field :last_name,   type: String,   default: nil
  field :email,       type: String,   default: nil
  field :gender,      type: Integer,  default: nil

  belongs_to :group

  validates :email,
            length:     { minimum: 6 },
            uniqueness: { case_sensitive: false },
            presence:   true,
            format:     { with: /([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$\z/i }


  def full_name
    ["#{first_name} #{last_name}", email].compact.reject(&:blank?).first
  end

  class << self
    def oauth_auth(access_token)
      at = AccessToken.find_by(token: access_token) if access_token.present?
      at ? at.user : nil
    end

    def basic_auth(email, password)
      if email.present? && password.present?
        user = find_by email: email
        (user && user.valid_password?(password)) ? user : nil
      end
    end
  end
end
