# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gifted/version'

Gem::Specification.new do |spec|
  spec.name          = 'gifted'
  spec.version       = Gifted::VERSION
  spec.authors       = ['Joel Moss']
  spec.email         = ['joel@developwithstyle.com']

  spec.summary       = 'Simple, yet Powerful Rails Decorators'
  spec.description   = 'Simple, yet Powerful Rails Decorators'
  spec.homepage      = 'https://github.com/joelmoss/gifted'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'test-unit-rails'
  spec.add_development_dependency 'selenium-webdriver'
  spec.add_development_dependency 'puma'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'byebug'
end
