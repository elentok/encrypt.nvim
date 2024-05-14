# encrypt.nvim

This is a simple alternative to the "X" command that was removed from Neovim.

Disclaimer: It's probably not the most secure implementation (if such thing is
even possible) but it gives the ability to edit files that will be stored in
encrypted on the disk.

## Usage

1. Open a file
2. Run `:X`
3. Enter a password

Now the file is encrypted and every time you open it you'll be asked for the
password.

## Installation

Add the following to your package manager:

```lua
{ "elentok/encrypt.nvim", opts = {} },
```

## TODO

- [ ] Store the password in a local scope in the plugin instead of as a buffer
      variable.
