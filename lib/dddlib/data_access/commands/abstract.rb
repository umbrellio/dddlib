# frozen_string_literal: true

class DDDLib::DataAccess::Commands::Abstract < DDDLib::Utils::Command
  option :repo, SmartCore::Types::Protocol::InstanceOf(DDDLib::DataAccess::Repository::Abstract)
end
