# frozen_string_literal: true

require "dddlib"

module DDDLib::Utils::ImportDSL
  def self.included(klass)
    mod = self

    klass.define_singleton_method(:import) do |mapping|
      mapping.each do |key, value|
        define_method(key) do
          ivar = :"@#{key}"
          instance_variable_get(ivar) || instance_variable_set(ivar, mod.resolve_import(value))
        end

        send(:private, key)
      end
    end
  end

  def self.resolve_import(...)
    raise "ImportDSL.resolve_import should be defined manually"
  end
end
