# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ExceptionHandler
  include Response

  private

  def page_permitted
    params.permit![:page]
  end
end
