# -*- encoding: utf-8 -*-
require File.expand_path('../lib/lego_nxt/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors               = ['Christian Höltje', 'Steve Klabnik']
  gem.email                 = ['docwhat@gerf.org', 'steve@steveklabnik.com']
  gem.description           = %q{A gem to interface with LEGO MINDSTORMS NXT bricks.}
  gem.summary               = %q{A gem to interface with LEGO MINDSTORMS NXT bricks.}
  gem.homepage              = 'http://github.com/docwhat/lego_nxt'

  gem.files                 = `git ls-files`.split($\)
  gem.executables           = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files            = gem.files.grep(%r{^(test|spec|features)/})
  gem.name                  = 'lego_nxt'
  gem.require_paths         = ['lib']
  gem.version               = LegoNXT::VERSION
  gem.required_ruby_version = '>= 1.9.2'

  gem.add_runtime_dependency 'libusb', '~> 0.1.3'

  gem.add_development_dependency 'rake', '~> 10.0'

  # Testing framework
  gem.add_development_dependency 'rspec', '~> 2.14'

  # Continous integration testing
  gem.add_development_dependency 'guard', '~> 2.4'
  gem.add_development_dependency 'guard-rspec', '~> 4.2'

  #For detecting changes in the filesystem
  gem.add_development_dependency 'rb-inotify', '~> 0.9'
  gem.add_development_dependency 'rb-fsevent', '~> 0.9'

  #For displaying notices
  gem.add_development_dependency 'terminal-notifier-guard', '~> 1.5'
  gem.add_development_dependency 'libnotify', '~> 0.8'

  # Documentation
  gem.add_development_dependency 'yard', '~> 0.8'
  gem.add_development_dependency 'redcarpet', '~> 3.0'
end
