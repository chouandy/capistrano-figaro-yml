# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "capistrano/figaro_yml/version"

Gem::Specification.new do |gem|
  gem.name          = "capistrano-figaro-yml"
  gem.version       = Capistrano::FigaroYml::VERSION
  gem.authors       = ["Chia-Hui Chou"]
  gem.email         = ["chouandy625@gmail.com"]
  gem.description   = <<-EOF.gsub(/^\s+/, "")
    Capistrano tasks for automating figaro `application.yml` file handling for Rails 4+ apps.

    This plugins syncs contents of your local figaro file and copies that to
    the remote server.
  EOF
  gem.summary       = "Capistrano tasks for automating figaro `application.yml` file handling for Rails 4+ apps."
  gem.homepage      = "https://github.com/ChouAndy/capistrano-figaro-yml"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'capistrano', '~> 3.1'
  gem.add_runtime_dependency 'sshkit', '~> 1.2', '>= 1.2.0'

  gem.add_development_dependency 'rake', '>= 0'
end
