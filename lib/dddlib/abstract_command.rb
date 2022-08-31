# frozen_string_literal: true

require "memery"

require_relative "initialization_dsl"
require_relative "import_dsl"
require_relative "class_attribute_dsl"

class DDDLib::AbstractCommand < Resol::Service
  include Memery
  include DDDLib::InitializationDSL
  include DDDLib::ImportDSL
  include DDDLib::ClassAttributeDSL
end
