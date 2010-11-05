Gem::Specification.new do |s|
  s.name              = "joe"
  s.version           = "0.1.1"
  s.summary           = "Release your gems, no pain involved."
  s.description       = "Joe takes you from a gem specification to world domination in a single step."
  s.authors           = ["Damian Janowski", "Michel Martens"]
  s.email             = ["djanowski@dimaion.com", "michel@soveran.com"]
  s.homepage          = "http://github.com/djanowski/joe"
  s.files = ["LICENSE", "README.markdown", "bin/joe", "lib/joe.rb"]

  s.executables.push("joe")
  s.add_dependency("clap")
end
