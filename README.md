# dot-files

My personal dot-files.

To get up and running with these, clone the repo and run the included `link-to-home` script.

# Notes

To ensure that `user_default.erl` gets executed, you have to manually compile it (`erlc user_default.erl`). Additionally, since it includes the webmachine headers (and mine are symlinks, so they aren't included in the repo) you will have to provide those yourself (at `.erlang.d/include`) or remove the `-include_lib`s.

# TODOs

+ improve error-handling of the `decompress` script
+ make including the webmachine hrl in user_default.erl more modular (i.e. not hard-coded)
+ include compilation of `user_default.erl` in the `link-to-home` script.
+ add webmachine as a git submodule to be able to include the symlinks?
