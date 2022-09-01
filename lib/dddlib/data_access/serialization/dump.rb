# frozen_string_literal: true

class DDDLib::DataAccess::Serialization::Dump < DDDLib::DataAccess::Serialization::Abstract
  class_and_instance_attribute :attr_mapping, :extra_attrs, :ignored_attrs

  delegate :model_class, to: :repo

  self.attr_mapping = {}
  self.extra_attrs = []
  self.ignored_attrs = []

  param :repo, SmartCore::Types::Protocol::InstanceOf(DDDLib::DataAccess::Repository::Abstract)

  def call
    success!(model_attrs)
  end

  private

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
