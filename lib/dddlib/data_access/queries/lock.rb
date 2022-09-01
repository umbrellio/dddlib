# frozen_string_literal: true

class DDDLib::DataAccess::Queries::Lock < DDDLib::DataAccess::Queries::Abstract
  param :entity, SmartCore::Types::Protocol::InstanceOf(DDDLib::Core::Entity)

  def call(&)
    result = run_repo_command!(DDDLib::DataAccess::Commands::Lock, repo:, entity:, &)
    success!(result)
  end
end
