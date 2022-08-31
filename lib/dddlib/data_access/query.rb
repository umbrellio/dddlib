# frozen_string_literal: true

require "dddlib/data_access/repository"
require "dddlib/utils/command"

class DDDLib::DataAccess::Query < DDDLib::Utils::Command
  # TODO? include Sentry::TagsMixin

  param :repo, SmartCore::Types::Protocol::InstanceOf(DDDLib::DataAccess::Repository)

  private

  def run_repo_command!(command_class, **options, &block)
    command_class.call(**options, &block).value_or do |error|
      fail!(error.code, error.data)
    end
  end
end
