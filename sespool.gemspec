$:.push File.expand_path("../lib", __FILE__)

require "sespool/version"

Gem::Specification.new do |s|
  s.name        = "sespool"
  s.license     = "MIT"
  s.version     = Sespool::VERSION
  s.authors     = ["Alex Smith"]
  s.email       = ["alex@thatalexguy.com"]
  s.homepage    = "https://github.com/ags/sespool"
  s.summary     = "Bounce parser for Amazon SES SNS notifications"
  s.description = "Bounce parser for Amazon SES SNS notifications"

  s.files = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
