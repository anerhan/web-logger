def klass
  described_class
end

def app
  App
end

def parsed_body
  JSON.parse(response_body)
end
