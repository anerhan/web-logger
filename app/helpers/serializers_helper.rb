module SerializersHelper
  def serialize(obj, options = {}, &block)
    if obj.is_a?(Array) || obj.is_a?(Mongoid::Criteria)
      headers 'X-PAGINATE' => paginate_attributes(obj).to_json
    end
    json obj, scope: current_ability
  end
end
