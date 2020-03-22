# frozen_string_literal: true

# Parse JSON response to ruby hash
module RequestHelper
  def json(body = response.body)
    JSON.parse(body, symbolize_names: true)
  end
end
