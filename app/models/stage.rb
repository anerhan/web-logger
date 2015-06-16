class Stage
  include Base

  field :name,        type: String
  field :ip,          type: String, default: '127.0.0.1'
  field :domain,      type: String, default: 'example.com'
  field :description, type: String, default: ''

  validates :name, :user_id, presence: true

  has_many   :projects
  belongs_to :user
end
