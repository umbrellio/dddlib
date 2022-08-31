# frozen_string_literal: true

require "dddlib"

module DDDLib::Core::EntityAttributes::Setters
  def self.included(base)
    base.extend_initialization_flow do |entity|
      entity.class.attributes.each do |_, attr|
        entity.singleton_class.class_eval do
          # :nocov:
          define_method("#{attr.name}=") do |value|
            attr.type.validate!(value)
            option_value = attr.cast? ? attr.type.cast(value) : value
            final_option_value = attr.finalizer.call(option_value, entity)
            entity.instance_variable_set("@#{attr.name}", final_option_value)
          end
          # :nocov:

          send(:private, "#{attr.name}=")
        end
      end
    end
  end
end
