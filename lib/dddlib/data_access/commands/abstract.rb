# frozen_string_literal: true

require "dddlib/utils/command"
require "dddlib/data_access/repositories/abstract"

class DDDLib::DataAccess::Commands::Abstract < DDDLib::Utils::Command
  option :repo, SmartCore::Types::Protocol::InstanceOf(DDDLib::DataAccess::Repositories::Abstract)
end
