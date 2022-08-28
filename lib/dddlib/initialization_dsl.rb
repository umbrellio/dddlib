# frozen_string_literal: true

module DDDLib::InitializationDSL
  extend ActiveSupport::Concern

  included do
    # :nocov:
    def provided_options
      options.compact
    end

    alias_method :provided_attributes, :provided_options

    def attribute_provided?(attr_name)
      !send(attr_name).nil?
    end
    # :nocov:
  end

  class_methods do
    def option?(name, type, **options)
      option(name, type.nilable, default: nil, **options)
    end
  end
end
