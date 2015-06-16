class AccessTokenSerializer < BaseSerializer
  attributes :token, :expired_at, :user_id

  def expired_at
    object.expired_at ? object.expired_at.utc.try(:strftime, "%FT%T%:z") : nil
  end

  def user_id
    object.user_id.to_s
  end
end
