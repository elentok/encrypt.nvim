# encrypt.nvim

This is a simple alternative to the "X" command that was removed from Neovim.

Disclaimer: It's probably not the most secure implementation (if such thing is
even possible) but it gives the ability to edit files while they are stored
in an encrypted format on the disk.

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

## Manual decryption

To decrypt a file that was encrypted using `decrypt.nvim` without the plugin
just run:

```
tail -n +2 encrypted.txt \
  | base64 --decode \
  | openssl enc -d -aes-256-cbc -pbkdf2 -salt -in - -out - -k {PASSWORD}
```

Or use the provided [decrypt.sh](decrypt.sh)

## TODO

- [ ] Store the password in a local scope in the plugin instead of as a buffer
      variable.
