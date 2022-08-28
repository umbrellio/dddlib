# frozen_string_literal: true

require_relative "domain_event"

class DDDLib::AbstractEventHandler < DDDLib::AbstractCommand
  param :event, SmartCore::Types::Protocol::InstanceOf(DDDLib::DomainEvent)
end
