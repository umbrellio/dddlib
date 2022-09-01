# frozen_string_literal: true

class DDDLib::DataAccess::Serialization::Abstract < DDDLib::Utils::Command
  class_and_instance_attribute :attr_mapping

  self.attr_mapping = {}

  param :repo, SmartCore::Types::Protocol::InstanceOf(DDDLib::DataAccess::Repository::Abstract)
end
