class Project
  include Base

  field :name,      type: String, default: nil
  field :settings,  type: Hash,   default: {}
  field :log_files, type: Array,  default: []

  validates :name, :log_files, presence: true

  belongs_to :stage
end
