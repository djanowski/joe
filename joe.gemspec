Gem::Specification.new do |s|
  s.name              = "joe"
  s.version           = "0.0.2"
  s.summary           = "Joe, the gem publisher"
  s.description       = "Joe builds on top of Thor’s awesomeness to take you from a gem specification to world domination in a single step."
  s.authors           = ["Damian Janowski", "Michel Martens"]
  s.email             = ["djanowski@dimaion.com", "michel@soveran.com"]
  s.homepage          = "http://github.com/djanowski/joe"
  s.files = ["LICENSE", "README.markdown", "bin/joe", "lib/joe.rb"]

  s.executables.push("joe")
  s.add_dependency("thor", "~> 0.11")
end
