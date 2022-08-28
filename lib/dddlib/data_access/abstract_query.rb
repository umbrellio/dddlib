# frozen_string_literal: true

class DDDLib::DataAccess::AbstractQuery < DDDLib::AbstractCommand
  require_relative "abstract_repository"

  # include Sentry::TagsMixin

  param :repo, SmartCore::Types::Protocol::InstanceOf(DDDLib::DataAccess::AbstractRepository)

  private

  def run_repo_command!(command_class, **options, &block)
    command_class.call(**options, &block).value_or do |error|
      fail!(error.code, error.data)
    end
  end
end
