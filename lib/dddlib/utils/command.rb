# frozen_string_literal: true

require "memery"
require "resol"

require "dddlib"
require "dddlib/utils/initialization_dsl"
require "dddlib/utils/import_dsl"
require "dddlib/utils/class_attribute_dsl"

class DDDLib::Utils::Command < Resol::Service
  include Memery
  include DDDLib::Utils::InitializationDSL
  include DDDLib::Utils::ImportDSL
  include DDDLib::Utils::ClassAttributeDSL
end
