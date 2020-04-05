# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ExceptionHandler
  include Response

  private

  def page_permitted
    params.permit![:page]
  end
end
