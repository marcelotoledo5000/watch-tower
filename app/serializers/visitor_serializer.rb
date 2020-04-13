# frozen_string_literal: true

class VisitorSerializer < ActiveModel::Serializer
  attributes :id, :name, :cpf, :profile_photo
end
