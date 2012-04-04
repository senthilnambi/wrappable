# Usage

First, you'll need Mr Bones installed:

    $ gem install bones

Then you'll want to “freeze” this skeleton in your install of Mr Bones, so you can use it to create new gems. I'm naming the skeleton 'hero', but you can name it whatever you want.

    $ bones freeze -r git://github.com/senthilnambi/hero.git hero

    # or
    $ bones freeze -r ~/path/to/folder/.git hero

Lastly, just use `-s hero` when creating a new library with bones and you're done:

    $ bones create -s hero mynewlib

Or you can add an alias to the above command. Add the following line to your `.bash_alias` file or equivalent zsh file (I simply did `source ~/.bash_alias` in my [.zshrc][0])

  [0]: https://github.com/senthilnambi/dotfiles/blob/master/dotfiles/.zshrc#L78

    # change bone and hero to match your names
    function bone {
      bones create -s hero mynewlib $1
    }

And then this works in any terminal. (Remember to restart the terminal for it to load the alias file.)

    $ bone mynewlib

Use downcase for `mynewlib` or name of the library.

# Inspiration

This skeleton and Readme is mostly from Brad Fults's [bones-skeleton-rspec2][1], which was originally inspired by Tom Preston-Werner's [RakeGem][2] and the default [Mr Bones][3] skeleton. I merely updated the Rakefile and customized it to my needs. I encourage you to do the same as well.

 [1]: https://github.com/h3h/bones-skeleton-rspec2
 [2]: http://github.com/mojombo/rakegem
 [3]: http://github.com/TwP/bones

# License

This skeleton is distributed under the MIT License. See the `License` file.
