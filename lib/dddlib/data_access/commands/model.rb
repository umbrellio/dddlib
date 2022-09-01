# frozen_string_literal: true

class DDDLib::DataAccess::Commands::Model < DDDLib::DataAccess::Commands::Find
  def call
    model = query.first or fail!(:not_found)
    success!(model)
  end
end
