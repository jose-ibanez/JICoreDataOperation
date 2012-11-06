//
//  JICoreDataOperation.m
//  Instagram
//
//  Created by Ibanez, Jose on 11/5/12.
//  Copyright (c) 2012 Jose Ibanez. All rights reserved.
//

#import "JICoreDataOperation.h"

@implementation JICoreDataOperation {
    BOOL _isExecuting, _isFinished;
}
@synthesize parentContext = _parentContext;
@synthesize managedObjectContext = _managedObjectContext;

- (id)init {
    return [self initWithParentContext:nil];
}

- (id)initWithParentContext:(NSManagedObjectContext *)parentContext {
    self = [super init];
    if (self) {
        _isExecuting = NO;
        _isFinished = NO;
        if (parentContext) {
            _parentContext = parentContext;
        }
    }
    return self;
}


#pragma mark - Properties

- (BOOL)isExecuting {
    return _isExecuting;
}

- (BOOL)isFinished {
    return _isFinished;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        NSAssert(_parentContext != nil, @"parent context is nil!");
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        _managedObjectContext.parentContext = _parentContext;
    }
    return _managedObjectContext;
}


#pragma mark - methods

- (void)start {
    // This method checks if the operation has been cancelled before raising the
    // isExecuting flag and calling doWork.  This should probably not be
    // overridden by child classes unless you want to duplicate it entirely.
    
//    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (!self.isCancelled) {
        [self willChangeValueForKey:@"isExecuting"];
        _isExecuting = YES;
        [self didChangeValueForKey:@"isExecuting"];
        [self doWork];
    }
    
    [self finish];
}

- (void)doWork {
    // This method should be overridden by child classes to perform whatever
    // tasks the operation is supposed to accomplish.  It should not return
    // until the operation is considered to be finished, so be careful if you
    // have any asynchonous method calls.
}

- (void)finish {
    // This method will save any changes made to the managed object context,
    // lower the isExecuting flag and raise the isFinished flag
    // If overridden by child classes, always call [super finish] LAST.
    
    if (_managedObjectContext && self.managedObjectContext.hasChanges) {
        [self.parentContext performBlockAndWait:^{
            NSError *error;
            do {
                error = nil;
                if (![self.managedObjectContext save:&error]) {
                    NSLog(@"error saving managed object context!\n%d - %@\ndebugInfo = %@\nuserInfo = %@", error.code, error.localizedDescription, error.debugDescription, error.userInfo);
                }
            } while (error && [self resolveSaveError:error]);
        }];
    }
    
    // lower the isExecuting flag
    if (self.isExecuting) {
        [self willChangeValueForKey:@"isExecuting"];
        _isExecuting = NO;
        [self didChangeValueForKey:@"isExecuting"];
    }
    
    // raise the isFinished flag
    [self willChangeValueForKey:@"isFinished"];
    _isFinished = YES;
    [self didChangeValueForKey:@"isFinished"];
//    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (BOOL)resolveSaveError:(NSError *)error {
    // optionally implemented by child classes to handle errors generated when
    // saving the context.
    return NO;
}


@end
