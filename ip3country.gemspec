Gem::Specification.new do |s|
    s.name        = 'ip3country'
    s.version     = '0.1.0'
    s.summary     = 'ip3country for ruby'
    s.description = 'A ruby, zero-dependency, super small version of IP2Location LITE country lookups'
    s.authors     = ['Statsig, Inc']
    s.email       = 'support@statsig.com'
    s.homepage    = 'https://rubygems.org/gems/ip3country'
    s.license     = 'ISC'
    s.files       = Dir['lib/**/*']
    s.add_development_dependency "bundler", "~> 2.1"
end
