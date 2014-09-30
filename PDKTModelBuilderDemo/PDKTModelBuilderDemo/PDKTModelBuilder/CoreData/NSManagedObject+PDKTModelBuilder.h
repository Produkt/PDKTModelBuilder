//
//  NSManagedObject+PDKTUtils.h
//  Portfolio
//
//  Created by Daniel García García on 31/08/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "PDKTModelBuilderEntity.h"

@protocol PDKTModelBuilderCoreDataEntity <PDKTModelBuilderEntity>
+ (NSString *)pdktmb_entityIdPropertyName;
@end

@interface NSManagedObject (PDKTModelBuilder)
+ (instancetype)updateOrInsertIntoManagedObjectContext:(NSManagedObjectContext *)managedObjectContext withDictionary:(NSDictionary *)dictionary;
+ (instancetype)insertIntoManagedObjectContext:(NSManagedObjectContext *)managedObjectContext withDictionary:(NSDictionary *)dictionary;
+ (instancetype)fetchObjectWithValue:(id)value forKey:(NSString *)key inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
@end
