# -*- encoding: utf-8 -*-
require './lib/wrappable/version'

Gem::Specification.new do |s|
  s.name        = "Wrappable"
  s.version     = Wrappable::VERSION
  s.authors     = ["Senthil A"]
  s.email       = ["senthil196@gmail.com"]
  s.homepage    = "https://github.com/senthilnambi/wrappable"
  s.summary     = %q{}
  s.description = %q{}

  s.rubyforge_project = "wrappable"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', '~> 2.8'
  s.add_development_dependency 'rake', '~> 0.9'
  s.add_development_dependency 'simplecov', '~> 0.5'

  # = MANIFEST =
  s.files = %w[
    Gemfile
    Rakefile
    Readme.markdown
    Spec.markdown
    wrappable.gemspec
    lib/wrappable.rb
    spec/wrappable_spec.rb
    spec/spec_helper.rb
  ]
  # = MANIFEST =
end
