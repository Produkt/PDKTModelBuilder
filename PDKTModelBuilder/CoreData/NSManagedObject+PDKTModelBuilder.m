//
//  NSManagedObject+PDKTUtils.m
//  PDKTModelBuilder
//
//  Created by Daniel García García on 31/08/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "NSManagedObject+PDKTModelBuilder.h"
#import "PDKTCoreDataEntityDataParserFactory.h"
#import <objc/runtime.h>

@implementation NSManagedObject (PDKTModelBuilderEntityDefault)
+ (NSString *)defaultEntityIdPropertyName{
    return [self defaultEntityIdPropertyNameForEntityName:[(id<PDKTModelBuilderCoreDataEntity>)self entityName]];
}
+ (NSString *)defaultEntityIdPropertyNameForEntityName:(NSString *)entityName{
    return [[NSString stringWithFormat:@"%@Id",[entityName stringByReplacingOccurrencesOfString:@"Entity" withString:@""]]stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[entityName substringToIndex:1]lowercaseString]];
}
+ (void)validateDefaultObjectId:(NSString *)objectId{
    __unused NSString *objectIdAssertMessage = [NSString stringWithFormat:@"uniqueId must be '%@' or must implement 'entityIdPropertyName'",objectId];
    __unused objc_property_t property = class_getProperty([self class], [objectId UTF8String]);
    NSAssert(property, objectIdAssertMessage);
}
@end

@implementation NSManagedObject (PDKTModelBuilder)
+ (instancetype)updateOrInsertIntoManagedObjectContext:(NSManagedObjectContext *)managedObjectContext withDictionary:(NSDictionary *)dictionary{
    NSAssert([[self class] conformsToProtocol:@protocol(PDKTModelBuilderCoreDataEntity)], @"must implement PDKTModelBuilderCoreDataEntity for using this method");
    NSString *entityName = [(id<PDKTModelBuilderCoreDataEntity>)self entityName];
    NSString *objectId = [self entityId];
    NSString *objectIdValue=[PDKTEntityDataParser propertyValueForKey:objectId inDictionary:dictionary forEntityClass:[self class]];
    if (!objectIdValue) {
        return nil;
    }
    NSManagedObject<PDKTModelBuilderEntity> *entity;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    fetchRequest.fetchLimit = 1;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%@ = %K",objectIdValue,objectId];
    
    NSArray *fetchResult=[managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    NSManagedObject<PDKTModelBuilderEntity> *matchedObject = [fetchResult lastObject];
    if (matchedObject){
        entity = matchedObject;
    }
    if (!entity)
    {
        entity = [NSEntityDescription insertNewObjectForEntityForName:[NSString stringWithFormat:@"%@",entityName] inManagedObjectContext:managedObjectContext];
    }
    PDKTEntityDataParser *entityDataParser = [PDKTCoreDataEntityDataParserFactory dataParserForCoreDataEntityWithDictionary:dictionary andEntity:entity];
    if ([entityDataParser executeDataParsing]) {
        if ([entity conformsToProtocol:@protocol(PDKTModelBuilderCoreDataEntity)] && [entity respondsToSelector:@selector(setEntityUpdateDate:)]) {
            [(NSManagedObject<PDKTModelBuilderCoreDataEntity> *)entity setEntityUpdateDate:[NSDate date]];
        }
    }
    return entity;
}
+ (instancetype)insertIntoManagedObjectContext:(NSManagedObjectContext *)managedObjectContext withDictionary:(NSDictionary *)dictionary{
    NSAssert([[self class] conformsToProtocol:@protocol(PDKTModelBuilderCoreDataEntity)], @"must implement PDKTModelBuilderCoreDataEntity for using this method");
    NSString *entityName = [(id<PDKTModelBuilderCoreDataEntity>)self entityName];
    NSString *objectIdValue=[self objectIdWithDictionary:dictionary];
    if (!objectIdValue) {
        return nil;
    }
    NSManagedObject<PDKTModelBuilderEntity> *newObject = [NSEntityDescription insertNewObjectForEntityForName:[NSString stringWithFormat:@"%@",entityName] inManagedObjectContext:managedObjectContext];
    PDKTEntityDataParser *entityDataParser = [PDKTCoreDataEntityDataParserFactory dataParserForCoreDataEntityWithDictionary:dictionary andEntity:newObject];
    [entityDataParser executeDataParsing];
    return newObject;
}
+ (NSString *)objectIdWithDictionary:(NSDictionary *)dictionary{
    NSString *objectId = [self entityId];
    NSString *objectIdValue=[PDKTEntityDataParser propertyValueForKey:objectId inDictionary:dictionary forEntityClass:[self class]];
    return objectIdValue;
}
+ (instancetype)fetchObjectWithValue:(id)value forKey:(NSString *)key inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[(id<PDKTModelBuilderCoreDataEntity>)self entityName]];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%@ = %K",value,key];
    fetchRequest.fetchLimit = 1;
    NSError *error=nil;
    NSArray *fetchResult=[managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"%@",error.userInfo);
    }
    NSManagedObject *fetchedObject=[fetchResult lastObject];
    return fetchedObject;
}
+ (NSString *)entityId{
    NSString *entityName = [(id<PDKTModelBuilderCoreDataEntity>)self entityName];
    NSString *objectId;
    if ([self respondsToSelector:@selector(entityIdPropertyName)]) {
        objectId = [(id<PDKTModelBuilderCoreDataEntity>)self entityIdPropertyName];
    }else{
        objectId = [self defaultEntityIdPropertyNameForEntityName:entityName];
        [self validateDefaultObjectId:objectId];
    }
    return objectId.length ? objectId : nil;
}

@end

