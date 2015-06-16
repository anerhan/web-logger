module JsonException
  def self.registered(app)
    app.error(401) { '{"errors":[{"code":"Unauthorized","message":"Invalid or expired token"}]}' }
    app.error(403) { '{"errors":[{"code":"not_authorized","message":"User is not authorised for this operation"}]}' }
    app.error(500) { '{"errors":[{"code":"Internal Server Error","message":"An internal server error occurred. Please try again later."}]}' }
    app.error(404) { '{"errors":[{"code":"not_found","message":"This page is not found"}]}' }
  end
end
