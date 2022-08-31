# frozen_string_literal: true

require_relative "lib/dddlib/version"

Gem::Specification.new do |spec|
  spec.name = "dddlib"
  spec.version = DDDLib::VERSION
  spec.authors = ["Umbrellio"]
  spec.email = ["oss@umbrellio.biz"]

  spec.summary = "DDD Library"
  spec.description = "DDD Library"
  spec.homepage = "https://github.com/umbrellio/dddlib"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport" # TODO: remove AS dependency
  spec.add_dependency "memery" # TODO: remove AS dependency
  spec.add_dependency "resol"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-json_matcher"
  spec.add_development_dependency "rubocop-config-umbrellio"
end
