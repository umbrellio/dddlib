# frozen_string_literal: true

class DDDLib::DataAccess::Serialization::DumpChangedAttributes <
      DDDLib::DataAccess::Serialization::Abstract
  class_and_instance_attribute :attr_mapping

  self.attr_mapping = {}

  param :repo, SmartCore::Types::Protocol::InstanceOf(DDDLib::DataAccess::Repository::Abstract)

  def call
    self.model_attrs = repo.dump_entity(entity)
    success!(model_changed_attrs)
  end

  private

  attr_accessor :model_attrs

  def model_changed_attrs
    model_attrs.select { |x| attribute_changed?(x) }
  end

  def attribute_changed?(attr_name)
    case
    when (proc = attr_mapping[attr_name])
      instance_exec(&proc)
    when entity.attributes.key?(attr_name)
      entity.changed_attributes.key?(attr_name)
    else
      fail!(
        :invalid_mapping,
        "Failed to dump changed attributes for #{entity}: no mapping for attribute <#{attr_name}>",
      )
    end
  end
end
