# frozen_string_literal: true

class DDDLib::DomainEvent < DDDLib::AbstractStruct
  include DDDLib::ImportDSL

  class_and_instance_attribute :type

  attribute :occurred_at, SmartCore::Types::Value::Time, default: -> { Time.current }
end
