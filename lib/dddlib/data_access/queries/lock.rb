# frozen_string_literal: true

require "dddlib/data_access/queries/abstract"
require "dddlib/core/entity"

class DDDLib::DataAccess::Queries::Lock < DDDLib::DataAccess::Queries::Abstract
  param :entity, SmartCore::Types::Protocol::InstanceOf(DDDLib::Core::Entity)

  def call(&block)
    result = run_repo_command!(
      DDDLib::DataAccess::Commands::Lock, repo: repo, entity: entity, &block
    )

    success!(result)
  end
end
