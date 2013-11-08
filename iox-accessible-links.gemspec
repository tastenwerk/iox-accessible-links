# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iox-accessible-links/version'

Gem::Specification.new do |spec|
  spec.name          = "iox-accessible-links"
  spec.version       = IoxAccessibleLinks::VERSION
  spec.authors       = ["thorsten zerha"]
  spec.email         = ["thorsten.zerha@tastenwerk.com"]
  spec.description   = %q{ grants accessible objects to share these objects via simple links }
  spec.summary       = %q{ accessible links plugin for ioX }
  spec.homepage      = "https://github.com/tastenwerk/iox-accessible-links"
  spec.license       = "GPLv3"

  spec.files = Dir["{app,config,db,lib}/**/*", "GPLv3-LICENSE", "Rakefile", "README.rdoc"]
  #spec.files         = `git ls-files`.split($/)
  #spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = Dir['spec/**/*']
  spec.require_paths = ["lib"]

  spec.add_dependency "iox-cms", "~> 0.1.2"

end
