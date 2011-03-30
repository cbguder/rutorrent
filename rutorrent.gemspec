# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rutorrent/version"

Gem::Specification.new do |s|
  s.name        = "rutorrent"
  s.version     = RUTorrent::VERSION
  s.platform    = Gem::Platform::RUBY

  s.authors     = ["Can Berk Güder"]
  s.email       = ["cbguder@gmail.com"]
  s.homepage    = "http://cbg.me/"

  s.summary     = %q{Library for the remote management of uTorrent clients}
  s.description = <<-EOF.strip.gsub(/^\s+/, '')
    RUTorrent is a Ruby library for the remote management of uTorrent clients
    via the Web UI API.
  EOF

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_dependency("json", "~> 1.5.1")
  s.add_dependency("nokogiri", "~> 1.4.4")

  s.add_development_dependency("bundler")
end
