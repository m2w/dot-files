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



### Licence

Copyright (c) 2013 Moritz Windelen
Permission is hereby granted, free of charge, to any person obtaining a copy of 
this software and associated documentation files (the "Software"), to deal in 
the Software without restriction, including without limitation the rights to 
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do 
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all 
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN 
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
