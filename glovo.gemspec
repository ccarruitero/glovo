
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'glovo/version'

Gem::Specification.new do |spec|
  spec.name          = 'glovo'
  spec.version       = Glovo::VERSION
  spec.authors       = ['César Carruitero']
  spec.email         = ['ccarruitero@protonmail.com']
  spec.homepage      = 'https://github.com/ccarruitero/glovo'

  spec.summary       = 'Ruby gem to use Glovo API'
  spec.description   = 'Ruby gem to comunicate with Glovo API'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.17'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'pry', '~> 0.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
