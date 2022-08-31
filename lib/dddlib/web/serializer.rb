# frozen_string_literal: true

require_relative "../utils/builder_dsl"
require_relative "../utils/import_dsl"

class DDDLib::Web::Serializer
  include DDDLib::Utils::BuilderDSL
  include DDDLib::Utils::ImportDSL

  def self.call(object, context = {})
    build(object, context).call
  end

  def self.collection(objects, context = {})
    objects.map { |object| call(object, context) }
  end

  def initialize(object, context = {})
    self.object = object
    self.context = context
  end

  private

  attr_accessor :object, :context
end
