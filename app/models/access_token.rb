class AccessToken
  include Base

  field :token,      type: String,   default: Proc.new { Exts::Base.hex_token }
  field :tmp_token,  type: String,   default: nil
  field :expired_at, type: DateTime, default: Proc.new { Time.now + Settings.auth.token_expired_period }

  belongs_to :user

  validates :token, presence: true
  validates :tmp_token, presence: true, if:     'self.new_record?'
  validates :user_id,   presence: true


  def reset_tmp_token!
    self.tmp_token = nil
    self.save
  end
end
