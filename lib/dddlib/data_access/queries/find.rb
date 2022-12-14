# frozen_string_literal: true

require "dddlib/data_access/queries/abstract"

class DDDLib::DataAccess::Queries::Find < DDDLib::DataAccess::Queries::Abstract
  param :id, SmartCore::Types::Protocol::InstanceOf(Object)

  def call
    success!(entity)
  end

  private

  def entity
    run_repo_command!(DDDLib::DataAccess::Commands::Find, repo: repo, where: { id: get_id })
  end

  def get_id
    id.is_a?(Values::EntityId) ? id.value : id
  end
end
