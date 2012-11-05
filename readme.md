#JICoreDataOperation

`JICoreDataOperation` is a simple NSOperation subclass that handles some of the code required to write to a managed object context in a background thread.  It manages the isExecuting and isFinished flags, creates a managedObjectContext on demand from a user-defined parentContext, and will save any changes to the local context upon finishing.

I seemed to be creating the same operation every time I wanted to perform some core data work in a background thread, so I figured I would just throw it up here on github to share.  Questions/comments/forks are more than welcome.

##How to use

1. Create a subclass of `JICoreDataOperation`.
2. Implement `- (void)doWork`.
3. At runtime, ensure you provide a parentContext to your subclass before you add it to a queue.
4. That's it!

##Requirements

This class assumes iOS 5.0 or newer and uses ARC.  This class is probably not appropriate for projects targeting iOS 4.3 or older in its current state.

##License

Copyright (c) 2012 José Ibáñez

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
