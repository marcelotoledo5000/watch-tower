# frozen_string_literal: true

module AuthHelper
  def request_headers_jwt(user)
    Devise::JWT::TestHelpers.auth_headers({}, user)
  end
end
