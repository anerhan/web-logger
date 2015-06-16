module Exts
  module Authenticable
    extend ActiveSupport::Concern

    included do
      field :encrypted_password, type: String,   default: ''

      attr_reader :password
      attr_accessor :password_confirmation
      validates :password, length: { within: 4..40 }, confirmation: true, presence: true, if: :password_required?
      validates :password_confirmation, presence: true, if: :password_required?
    end

    def authenticatable_salt
      encrypted_password[0, 29] if encrypted_password
    end

    def clean_up_passwords
      self.password = self.password_confirmation = nil
    end

    def password=(new_password)
      @password = new_password
      self.encrypted_password = password_digest(@password) if @password.present?
    end

    def update_with_password(params, *options)
      pass = params.delete(:password)
      if pass.blank?
        params.delete(:password)
        params.delete(:password_confirmation) if params[:password_confirmation].blank?
      end
      result = if valid_password?(pass)
                 update_attributes(params, *options)
               else
                 self.assign_attributes(params, *options)
                 self.valid?
                 self.errors.add(:password, pass.blank? ? :blank : :invalid)
                 false
               end
      clean_up_passwords
      result
    end

    def update_without_password(params, *options)
      params.delete(:password)
      params.delete(:password_confirmation)
      result = update_attributes(params, *options)
      clean_up_passwords
      result
    end

    def valid_password?(password)
      return false if encrypted_password.blank?
      bcrypt = ::BCrypt::Password.new(encrypted_password)
      password = ::BCrypt::Engine.hash_secret("#{password}marat", bcrypt.salt)
      Exts::Base.secure_compare(password, encrypted_password)
    end

    def set_random_password(new_password = nil)
      new_password ||= SecureRandom.hex(8)
      self.password = new_password
      self.password_confirmation = new_password
      new_password
    end

    def set_random_password!(new_password = nil)
      set_random_password(new_password)
      self.save validate: false
      new_password
    end

    protected
    def password_required?
      password.present?
    end

    # Digests the password using bcrypt.
    def password_digest(password)
      ::BCrypt::Password.create("#{password}marat", cost: 10).to_s
    end
  end
end
