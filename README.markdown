Joe
===

Releasing gems to RubyForge has always been a pain. There's Hoe you say? Yes, but Hoe is a pain disguised as a virus.

Meet Joe, the ultimate gem publisher.


Usage
-----

Joe assumes you have a .gemspec file in the current directory and it will use it to build the gem. Once you have it, try this:

    $ thor joe:package

Congratulations, you should have your gem built and an archive copy inside the `pkg` directory.

Now go ahead and release your new gem to RubyForge:

    $ thor joe:release

Easy, right? Wait a few minutes until RubyForge updates its gems index and you will be able to run `sudo gem install foo`.


Troubleshooting
---------------

If you get an error about a missing `group_id`, try running `rubyforge config`. This hooks up your RubyForge account with the gem and configures where to release it.


Maintaining a gemspec file
--------------------------

The easiest way I've found to maintain a gemspec file is by creating a `foo.gemspec.erb` template ([see example](http://github.com/soveran/ohm/blob/6c3e7d89d40de8de9eb7a0f772b38bcb8996a8f9/ohm.gemspec.erb)). Then you can use a Thor task to produce the real gemspec file:

    $ thor joe:gemspec


Installation
------------

You need the `rubyforge` gem in order to release files. If you don't have it already:

    $ sudo gem install rubyforge
    $ rubyforge setup
    $ rubyforge config

Make sure you have Thor installed:

    $ sudo gem install thor

And then simply:

    $ thor install http://dimaion.com/joe/joe.thor

That's it. Try:

    $ thor -T

And you will get a list of Thor tasks.


Thanks
------

Thanks to Blake Mizerany for pointing me to the Sinatra Rakefile for reference.


License
-------

See `LICENSE`, but basically MIT.
