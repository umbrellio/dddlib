# frozen_string_literal: true

require "active_support/core_ext/class/attribute"

# :nocov:
module DDDLib::ClassAttributeDSL
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    def class_and_instance_attribute(*attrs)
      generate_class_attribute(*attrs, instance_reader: true)
    end

    def class_only_attribute(*attrs)
      generate_class_attribute(*attrs)
    end

    private

    def generate_class_attribute(*attrs, **options)
      class_attribute(*attrs, instance_accessor: false, instance_predicate: false, **options)
    end
  end
end
