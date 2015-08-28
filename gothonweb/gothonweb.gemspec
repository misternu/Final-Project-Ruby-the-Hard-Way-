# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "gothonweb"
  spec.version       = '1.0'
  spec.authors       = ["Timothy Meixell"]
  spec.email         = ["misternu@gmail.com"]
  spec.summary       = %q{Short summary of your project}
  spec.description   = %q{Longer description of your project.}
  spec.homepage      = ""
  spec.license       = ""

  spec.files         = ['lib/gothonweb.rb']
  spec.executables   = ['gothonweb']
  spec.test_files    = ['tests/test_gothonweb.rb']
  spec.require_paths = ["lib"]
end