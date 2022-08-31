# frozen_string_literal: true

require_relative "abstract_struct"

class DDDLib::AbstractEntity < DDDLib::AbstractStruct
  require_relative "abstract_entity/attributes_setters"
  require_relative "abstract_entity/attributes_tracking"

  include DDDLib::ImportDSL
  include DDDLib::AbstractEntity::AttributesSetters
  include DDDLib::AbstractEntity::AttributesTracking

  import event_bus: "tools.event_bus"

  def ==(other)
    return false unless instance_of?(other.class)
    id == other.id
  end

  def patch_attributes!(attributes)
    attributes.except(:id).index_with { |attribute, value| send("#{attribute}=", value) }
  end
end
