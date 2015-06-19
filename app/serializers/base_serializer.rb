class BaseSerializer < ActiveModel::Serializer
  ACL_LIST = [ :list, :view, :create, :update, :delete]
  attributes :id, :created_at, :updated_at, :meta

  def id
    object.id.to_s
  end

  def created_at
    object.created_at ? object.created_at.utc.try(:strftime, "%FT%T%:z") : nil
  end

  def updated_at
    object.updated_at ? object.updated_at.utc.try(:strftime, "%FT%T%:z") : nil
  end

  def meta
    { ability: ACL_LIST.select { |a| scope.can? a, object } }.to_json
  end
end
