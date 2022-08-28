# frozen_string_literal: true

require_relative "builder_dsl"
require_relative "initialization_dsl"
require_relative "import_dsl"
require_relative "class_attribute_dsl"

class DDDLib::AbstractStruct
  include DDDLib::BuilderDSL
  include SmartCore::Initializer
  include DDDLib::InitializationDSL
  include DDDLib::ImportDSL
  include DDDLib::ClassAttributeDSL
  include Memery

  class << self
    def attribute(name, type, **options)
      option(name, type, default: nil, **options)
    end

    def attribute?(name, type, **options)
      attribute(name, type.nilable, **options)
    end

    def attributes
      __options__.index_by(&:name)
    end

    def attribute_names
      attributes.keys
    end
  end

  alias attributes __attributes__
end
