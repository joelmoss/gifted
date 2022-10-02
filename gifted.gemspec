# frozen_string_literal: true

require_relative 'lib/gifted/version'

Gem::Specification.new do |spec|
  spec.name          = 'gifted'
  spec.version       = Gifted::VERSION
  spec.authors       = ['Joel Moss']
  spec.email         = ['joel@developwithstyle.com']

  spec.summary       = 'Simple, yet Powerful Rails Decorators'
  spec.description   = 'Simple, yet Powerful Rails Decorators'
  spec.homepage      = 'https://github.com/joelmoss/gifted'
  spec.license       = 'MIT'

  spec.files = Dir['{lib}/**/*', 'CODE_OF_CONDUCT.md', 'README.md', 'LICENSE.txt']
  spec.require_paths = ['lib']
end
