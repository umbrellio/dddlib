# frozen_string_literal: true

require "memery"

require "dddlib"
require "dddlib/utils/builder_dsl"
require "dddlib/utils/initialization_dsl"
require "dddlib/utils/import_dsl"
require "dddlib/utils/class_attribute_dsl"

class DDDLib::Utils::Struct
  include DDDLib::Utils::BuilderDSL
  include DDDLib::Utils::InitializationDSL
  include DDDLib::Utils::ImportDSL
  include DDDLib::Utils::ClassAttributeDSL
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
