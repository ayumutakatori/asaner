
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "asaner/version"

Gem::Specification.new do |spec|
  spec.name          = "asaner"
  spec.version       = Asaner::VERSION
  spec.authors       = ["Katsumata Ryo"]
  spec.email         = ["ktmt.ryo@gmail.com"]

  spec.summary       = %q{Asana API client for ruby}
  spec.description   = %q{Asana API client for ruby}
  spec.homepage      = "https://github.com/katsumata-ryo/asaner"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
