# frozen_string_literal: true

require "dddlib"

module DDDLib::Core::EntityAttributes::Tracking
  module PrependedMethods
    def patch_attributes!(attributes)
      super(attributes).tap { delete_changed_attributes!(*attributes.keys) }
    end

    def changed_attributes
      @changed_attributes ||= {}
    end

    private

    attr_accessor :initial_attributes

    def attr_has_changed!(attr, new_value)
      initial_value = initial_attributes[attr]

      if initial_value.eql?(new_value)
        delete_changed_attributes!(attr)
      else
        add_changed_attribute!(attr, initial_value, new_value)
      end
    end

    def add_changed_attribute!(attr, from, to)
      changed_attributes[attr] = { from: from, to: to }
    end

    def delete_changed_attributes!(*attrs)
      changed_attributes.except!(*attrs)
    end
  end

  def self.included(othermod)
    othermod.prepend(PrependedMethods)

    othermod.extend_initialization_flow do |entity|
      entity.send(:initial_attributes=, entity.attributes)
      prepended_methods = Module.new

      entity.class.attribute_names.each do |attr|
        prepended_methods.define_method("#{attr}=") do |value|
          super(value).tap { |new_value| attr_has_changed!(attr, new_value) }
        end

        prepended_methods.send(:private, "#{attr}=")
      end

      entity.singleton_class.prepend(prepended_methods)
    end
  end
end
