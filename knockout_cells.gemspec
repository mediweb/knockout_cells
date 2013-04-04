$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "knockout_cells/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "knockout_cells"
  s.version     = KnockoutCells::VERSION
  s.authors     = ["Arek Turlewicz"]
  s.email       = ["arek@turlewicz.com"]
  s.homepage    = "github.com/arekt/knockout_cells"
  s.summary     = "Usefull cells powered by knockout.js to build your web application faster."
  s.description = "Merging power of rails cells and knockout.js"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.12"
  s.add_dependency "cells", "3.8.8"

  s.add_development_dependency "sqlite3"
end
