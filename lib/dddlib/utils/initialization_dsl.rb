# frozen_string_literal: true

require "active_support/concern"
require "smart_core/initializer"

require "dddlib"

module DDDLib::Utils::InitializationDSL
  extend ActiveSupport::Concern

  included do
    include SmartCore::Initializer

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
