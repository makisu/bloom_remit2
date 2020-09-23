require_relative 'lib/bloom_remit2/version'

Gem::Specification.new do |spec|
  spec.name          = "bloom_remit2"
  spec.version       = BloomRemit2::VERSION
  spec.authors       = ["Xavi Ablaza"]
  spec.email         = ["xlablaza@gmail.com"]

  spec.summary       = %q{Ruby wrapper for BloomRemit's API}
  spec.homepage      = "https://github.com/makisu/bloom_remit2"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/makisu/bloom_remit2"
  spec.metadata["changelog_uri"] = "https://github.com/makisu/bloom_remit2/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport'
  spec.add_dependency 'gem_config'
  spec.add_dependency 'httparty'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec_junit_formatter"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "prettier"
end
