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
