# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "self_enumerable/version"

Gem::Specification.new do |spec|
  spec.name          = "self_enumerable"
  spec.version       = SelfEnumerable::VERSION
  spec.authors       = ["Michael Sievers"]
  spec.summary       = %q{Extended Enumerable module which returns instances of an objects class instead of plain arrays.}
  spec.licenses      = ["MIT"]
  spec.homepage      = "https://github.com/msievers/self_enumerable"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
