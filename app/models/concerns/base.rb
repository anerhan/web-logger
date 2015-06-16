require 'kaminari/models/mongoid_extension'

module Base
 extend ActiveSupport::Concern
 included do
    include Mongoid::Document
    include Mongoid::Timestamps
    # include Mongoid::Paranoia # Without real Deletions, only set deleted_at
    include Kaminari::MongoidExtension::Document
    default_scope -> { order_by([:created_at, :desc]) }
  end
end
