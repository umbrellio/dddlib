# frozen_string_literal: true

require "dddlib/data_access/serialization/abstract"
require "dddlib/core/entity"

class DDDLib::DataAccess::Serialization::Load < DDDLib::DataAccess::Serialization::Abstract
  option? :entity_to_reload, SmartCore::Types::Protocol::InstanceOf(DDDLib::Core::Entity)

  def call
    success!(entity)
  end

  private

  def entity
    if attribute_provided?(:entity_to_reload)
      entity_to_reload.tap { |x| x.patch_attributes!(entity_attrs) }
    else
      entity_class.new(**entity_attrs)
    end
  end

  def entity_class
    repo.entity_class
  end

  def entity_attrs
    entity_class.attribute_names.index_with { |x| get_value!(x) }
  end

  def get_value!(attr_name)
    case
    when (proc = attr_mapping[attr_name])
      instance_exec(&proc)
    when model_class_attrs.include?(attr_name)
      prepare_db_value(model.public_send(attr_name))
    else
      fail!(:invalid_mapping, "Failed to load #{model}: no mapping for attribute <#{attr_name}>")
    end
  end

  def prepare_db_value(value)
    case value
    when Sequel::Postgres::JSONBHash
      value.to_h
    # :nocov:
    when Sequel::Postgres::PGArray
      value.to_a
    # :nocov:
    else
      value
    end
  end

  memoize def model_class_attrs
    model.class.attributes.to_set
  end
end
