//
//  PDKTEntityRelationship.h
//  PDKTModelBuilder
//
//  Created by Daniel García García on 06/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDKTModelBuilder+CoreData.h"

@interface PDKTCoreDataEntityRelationship : NSObject
@property (copy,nonatomic,readonly) NSString *keyPath;
@property (assign,nonatomic,readonly) Class relatedClass;
+ (instancetype)oneToOneRelationshipForKeyPath:(NSString *)keyPath andClass:(Class)relatedClass;
+ (instancetype)oneToManyRelationshipForKeyPath:(NSString *)keyPath andClass:(Class)relatedClass;
- (void)parseRelationshipInDictionary:(NSDictionary *)dictionary withEntity:(NSObject *)entity relationshipProperty:(NSString *)relationshipProperty inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
@end
