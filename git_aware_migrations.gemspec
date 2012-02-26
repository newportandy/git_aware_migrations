# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = "git_aware_migrations"
  s.version     = `cat VERSION`.strip
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Andy Newport']
  s.email       = []
  s.homepage    = "https://github.com/newporta/GitAwareMigrations"
  s.summary     = "Migrates your database from the git revision the migration was completed in."
  s.description = ""

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "git_aware_migrations"

  s.add_development_dependency "bundler", ">= 1.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
