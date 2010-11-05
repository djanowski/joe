Joe
===

Release your gems, no pain involved.


Usage
-----

Joe assumes you have a .gemspec file in the current directory and it will use it to build the gem. Once you have it, try this:

    $ joe build

Congratulations, you should have your gem built inside the `pkg` directory.

Now go ahead and release your new gem to RubyGems.org:

    $ joe release

Easy, right? Wait until RubyGems.org updates its gems index and you will be able to run `gem install foo`.


Maintaining a gemspec file
--------------------------

The easiest way we've found to maintain a gemspec file is by creating a `foo.gemspec.erb` template ([see example](https://github.com/soveran/ohm/blob/master/ohm.gemspec.erb)). Then you can use Joe to produce the real gemspec file:

    $ joe gemspec


Installation
------------

    $ gem install joe

That's it. Try:

    $ joe

And you will get a list of available tasks.


Thanks
------

Thanks to Blake Mizerany for pointing us to the Sinatra Rakefile for reference.


License
-------

Copyright (c) 2009 Damian Janowski and Michel Martens

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
