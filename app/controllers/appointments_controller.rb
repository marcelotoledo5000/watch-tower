# frozen_string_literal: true

class AppointmentsController < ApplicationController
  authorize_resource

  # POST /appointments
  def create
    Appointment.create!(appointment_params).then do |appointment|
      json_response appointment, :created
    end
  end

  # GET /appointments
  def index
    Appointment.all.then do |result|
      result.page(page_permitted).then do |appointments|
        json_response appointments
      end
    end
  end

  private

  def appointment_params
    params.require(:appointment).
      permit(:visitor_id, :store_id, :kind, :event_time)
  end
end
