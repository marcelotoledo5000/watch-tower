# frozen_string_literal: true

class FilterStoresService
  attr_reader :cnpj, :name

  def initialize(params = {})
    @cnpj = params[:cnpj]
    @name = params[:name]
  end

  def perform
    by_cnpj
    by_name

    stores
  end

  private

  attr_accessor :stores

  def stores
    @stores ||= Store.all
  end

  def by_cnpj
    return stores if cnpj.blank?

    @stores = Store.where(cnpj: cnpj.to_i)
  end

  def by_name
    return stores if name.blank?

    @stores = Store.where('name ILIKE ?', "%#{name}%")
  end
end
