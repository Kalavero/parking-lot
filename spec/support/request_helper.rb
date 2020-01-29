# frozen_string_literal: true
module RequestHelper
  def json_response
    JSON.parse(response.body).deep_symbolize_keys
  end
end
