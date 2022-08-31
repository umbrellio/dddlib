# frozen_string_literal: true

require "dddlib/utils/struct"
require "dddlib/utils/import_dsl"

class DDDLib::Core::DomainEvent < DDDLib::Utils::Struct
  include DDDLib::Utils::ImportDSL

  class_and_instance_attribute :type

  attribute :occurred_at, SmartCore::Types::Value::Time, default: -> { Time.current }
end
