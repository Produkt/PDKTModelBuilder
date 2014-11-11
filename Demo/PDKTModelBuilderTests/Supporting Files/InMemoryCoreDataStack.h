//
//  InMemoryCoreDataStack.h
//
//  Created by Daniel García on 13/05/14.
//  Copyright (c) 2014 Produkt All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface InMemoryCoreDataStack : NSObject
@property (strong,nonatomic,readonly) NSManagedObjectContext *managedObjectContext;
- (instancetype)initWithModelName:(NSString *)modelName;
@end
