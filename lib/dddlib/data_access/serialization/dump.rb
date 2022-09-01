# frozen_string_literal: true

require "dddlib/data_access/serialization/abstract"

class DDDLib::DataAccess::Serialization::Dump < DDDLib::DataAccess::Serialization::Abstract
  class_and_instance_attribute :extra_attrs, :ignored_attrs

  self.extra_attrs = []
  self.ignored_attrs = []

  def call
    success!(model_attrs)
  end

  private

  def model_class
    model_class.repo
  end

  def model_attrs
    (model_class.attributes + extra_attrs - ignored_attrs).index_with { |x| get_value!(x) }
  end

  def get_value!(attr_name)
    case
    when (proc = attr_mapping[attr_name])
      instance_exec(&proc)
    when entity.attributes.key?(attr_name)
      prepare_entity_value(entity.public_send(attr_name))
    else
      fail!(:invalid_mapping, "Failed to dump #{entity}: no mapping for attribute <#{attr_name}>")
    end
  end

  def prepare_entity_value(value)
    case value
    when DDDLib::Core::Value
      value.value
    else
      value
    end
  end

  def existing_or_new_guid
    entity.guid || repo.generate_guid
  end
end
