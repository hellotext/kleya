Gem::Specification.new do |s|
  s.name = 'kleya'
  s.version = '0.0.1'
  s.summary = 'Screenshots, made easy.'
  s.description = 'Screenshots, made easy.'
  s.authors = ['Hellotext', 'Ahmed Khattab']
  s.files = Dir.glob('lib/**/*.rb') + Dir.glob('test/**/*.rb') + %w[Rakefile README.md]
  s.require_paths = ['lib']
  s.homepage = 'https://github.com/hellotext/kleya'
  s.license = 'MIT'

  s.required_ruby_version = '>= 3.3.0'

  s.add_development_dependency 'minitest', '~> 5.14'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'yard', '~> 0.9'
  s.add_development_dependency 'webmock', '~> 3.25'

  s.add_dependency 'ferrum', '~> 0.17'
end
