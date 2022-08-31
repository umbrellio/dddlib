# frozen_string_literal: true

require "dddlib/utils/struct"
require "dddlib/utils/import_dsl"
require "dddlib/core/entity_attributes/setters"
require "dddlib/core/entity_attributes/tracking"

class DDDLib::Core::Entity < DDDLib::Utils::Struct
  include DDDLib::Utils::ImportDSL
  include DDDLib::Core::EntityAttributes::Setters
  include DDDLib::Core::EntityAttributes::Tracking

  import event_bus: "tools.event_bus"

  def ==(other)
    return false unless instance_of?(other.class)
    id == other.id
  end

  def patch_attributes!(attributes)
    attributes.except(:id).index_with { |attribute, value| send("#{attribute}=", value) }
  end
end
