# frozen_string_literal: true

require_relative "lib/dddlib/version"

Gem::Specification.new do |spec|
  spec.name = "dddlib"
  spec.version = DDDLib::VERSION
  spec.authors = ["Yuri Smirnov"]
  spec.email = ["tycooon@yandex.ru"]

  spec.summary = "DDD Library"
  spec.description = "DDD Library"
  spec.homepage = "https://fixme.com/"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://fixme.com/"
  spec.metadata["changelog_uri"] = "https://fixme.com/"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "resol", "~> 0.7"
  spec.add_dependency "activesupport", "~> 7.0" # TODO: remove AS dependency
  spec.add_dependency "memery", "~> 1.0" # TODO: remove AS dependency
end
