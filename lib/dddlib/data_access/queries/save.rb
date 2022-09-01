# frozen_string_literal: true

require "dddlib/data_access/queries/abstract"
require "dddlib/core/entity"

class DDDLib::DataAccess::Queries::Save < DDDLib::DataAccess::Queries::Abstract
  param :entity, SmartCore::Types::Protocol::InstanceOf(DDDLib::Core::Entity)

  def call
    success!(result)
  end

  private

  def result
    run_repo_command!(DDDLib::DataAccess::Commands::Save, repo: repo, entity: entity)
  end
end
