# frozen_string_literal: true

require "dddlib/utils/command"
require "dddlib/data_access/repositories/abstract"

class DDDLib::DataAccess::Serialization::Abstract < DDDLib::Utils::Command
  class_and_instance_attribute :attr_mapping

  self.attr_mapping = {}

  param :repo, SmartCore::Types::Protocol::InstanceOf(DDDLib::DataAccess::Repositories::Abstract)
end
