# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ExceptionHandler
  include Response

  before_action :authenticate_user!

  private

  def page_permitted
    params.permit![:page]
  end
end
