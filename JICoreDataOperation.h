//
//  JICoreDataOperation.h
//  Instagram
//
//  Created by Ibanez, Jose on 11/5/12.
//  Copyright (c) 2012 Jose Ibanez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JICoreDataOperation : NSOperation

@property (nonatomic, strong, readwrite) NSManagedObjectContext *parentContext;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

- (id)initWithParentContext:(NSManagedObjectContext *)parentContext;

- (void)doWork;
- (void)finish;
- (BOOL)resolveSaveError:(NSError *)error;

@end
