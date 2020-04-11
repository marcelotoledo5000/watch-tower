# frozen_string_literal: true

class AppointmentSerializer < ActiveModel::Serializer
  attributes :visitor, :store, :kind, :event_time

  def visitor
    Visitor.find(object.visitor_id).name
  end

  def store
    Store.find(object.store_id).name
  end

  def event_time
    object.event_time.strftime('%FT%T')
  end
end
