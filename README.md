# DEPRECATED please use [haskell-language-server](https://github.com/haskell/haskell-language-server) with [coc.nvim](https://github.com/neoclide/coc.nvim)

Introduction
------------

The executable cabal-lint gives you the result of a fresh "cabal new-build" command as if you were in the nearest parent directory containing a .cabal. Even if your program compiles, instead of giving you the message "Up to date", it will prompt you with the previous warnings.

It is particularly useful in conjunction with the vim plugin [neomake](https://github.com/neomake/neomake) and the plugin [cabal-lint-neomake](https://github.com/fyusuf-a/cabal-lint-neomake).
