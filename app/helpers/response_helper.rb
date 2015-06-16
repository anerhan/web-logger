module ResponseHelper
  def serialize_and_response(object, &block)
    yield(object) if block_given?
    # POST =>
    if request.post?
      if !object.errors.any?
        status 201
      else
        headers 'X-ERRORS' => object.errors.to_json
        status 500
      end
    # GET =>
    elsif request.get?
      if object
        status 200
        serialize object
      else
        status 404
      end
    # PUT =>
    elsif request.put?
      if !object.errors.any?
        status 200
        serialize object
      else
        headers 'X-ERRORS' => object.errors.to_json
        status 500
      end
    # DELETE =>
    elsif request.delete?
      status(object ? 200 : 404)
    end
  end
end
