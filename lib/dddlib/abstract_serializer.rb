# frozen_string_literal: true

class DDDLib::AbstractSerializer
  include DDDLib::BuilderDSL
  include DDDLib::ImportDSL

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
