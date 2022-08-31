# frozen_string_literal: true

require "dddlib/utils/import_dsl"
require "dddlib/utils/class_attribute_dsl"

class DDDLib::DataAccess::Repository
  include DDDLib::Utils::ImportDSL
  include DDDLib::Utils::ClassAttributeDSL

  InvalidReturnType = Class.new(StandardError)

  class_and_instance_attribute(
    :entity_loader,
    :entity_dumper,
    :entity_changed_attrs_dumper,
    :entity_class,
    :model_class,
  )

  def self.register_query(name, klass)
    define_method(name) do |*args, **options, &block|
      klass.call(self, *args, **options, &block)
    end

    # :nocov:
    define_method("#{name}!") do |*args, **options, &block|
      public_send(name, *args, **options, &block).value_or { |error| raise error }
    end
    # :nocov:
  end

  def load_entity(model, **attrs)
    entity_loader.call!(self, model, **attrs)
  end

  def dump_entity(entity, **attrs)
    entity_dumper.call!(self, entity, **attrs)
  end

  def dump_entity_changed_attributes(entity, **attrs)
    entity_changed_attrs_dumper.call!(self, entity, **attrs)
  end

  def generate_guid(...)
    self.class.generate_guid(...)
  end
end
