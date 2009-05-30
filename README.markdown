Joe
===

This is just a collection of Thor tasks to deal with packaging a gem and publishing it to RubyForge. Take a look at the source code – it's very simple.

Thanks to Blake Mizerany for pointing me to the Sinatra Rakefile for reference.


Installation
---

Make sure you have Thor installed:

    $ sudo gem install thor

And then simply:

    $ thor install http://dimaion.com/joe/joe.thor

That's all.

Now try:

    $ thor -T

And you should get a list of Thor tasks.


Usage
---

Considering you have a `foo.gemspec` in the current directory, these should work:

    $ thor joe:package
    $ thor joe:release

Note that the `joe:release` task relies on the `rubyforge` command, gently provided by your fellow `rubyforge` gem. If you don't have it:

    $ sudo gem install rubyforge
    $ rubyforge setup
    $ rubyforge config

Maintaining a gemspec file
---

The easiest way I've found to maintain a gemspec file is by creating a `foo.gemspec.erb` template ([see example](http://github.com/soveran/ohm/blob/6c3e7d89d40de8de9eb7a0f772b38bcb8996a8f9/ohm.gemspec.erb)). Then you can use a Thor task to produce the real gemspec file:

    $ thor joe:gemspec


License
---

See `LICENSE`, but basically MIT.


Contributing
---

This is just a late night's hack. I'll be glad to take patches in the form of pull requests.
