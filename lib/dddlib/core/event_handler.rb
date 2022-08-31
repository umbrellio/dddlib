# frozen_string_literal: true

require "dddlib/core/domain_event"
require "dddlib/utils/command"

class DDDLib::Core::EventHandler < DDDLib::Utils::Command
  param :event, SmartCore::Types::Protocol::InstanceOf(DDDLib::Core::DomainEvent)
end
