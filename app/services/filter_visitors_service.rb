# frozen_string_literal: true

class FilterVisitorsService
  attr_reader :cpf, :name

  def initialize(params = {})
    @cpf = params[:cpf]
    @name = params[:name]
  end

  def perform
    by_cpf
    by_name

    visitors
  end

  private

  def visitors
    @visitors ||= Visitor.all
  end

  def by_cpf
    return visitors if cpf.blank?

    @visitors = Visitor.where(cpf: cpf.to_i)
  end

  def by_name
    return visitors if name.blank?

    @visitors = Visitor.where('name ILIKE ?', "%#{name}%")
  end
end
