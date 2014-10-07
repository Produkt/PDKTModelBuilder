//
//  NSManagedObject+PDKTUtils.m
//  Portfolio
//
//  Created by Daniel García García on 31/08/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "NSManagedObject+PDKTModelBuilder.h"
#import "PDKTEntityDataParser.h"
#import <objc/runtime.h>

@implementation NSManagedObject (PDKTModelBuilderEntityDefault)
+ (NSString *)defaultEntityIdPropertyName{
    return [self defaultEntityIdPropertyNameForEntityName:NSStringFromClass([self class])];
}
+ (NSString *)defaultEntityIdPropertyNameForEntityName:(NSString *)entityName{
    return [[NSString stringWithFormat:@"%@Id",[entityName stringByReplacingOccurrencesOfString:@"Entity" withString:@""]]stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[entityName substringToIndex:1]lowercaseString]];
}
+ (void)validateDefaultObjectId:(NSString *)objectId{
    NSString *objectIdAssertMessage = [NSString stringWithFormat:@"uniqueId must be '%@' or must implement 'pdktmb_entityIdPropertyName'",objectId];
    objc_property_t property = class_getProperty([self class], [objectId UTF8String]);
    NSAssert(property, objectIdAssertMessage);
}
@end

@implementation NSManagedObject (PDKTModelBuilder)
+ (instancetype)updateOrInsertIntoManagedObjectContext:(NSManagedObjectContext *)managedObjectContext withDictionary:(NSDictionary *)dictionary{
    NSAssert([[self class] conformsToProtocol:@protocol(PDKTModelBuilderCoreDataEntity)], @"must implement PDKTModelBuilderCoreDataEntity for using this method");
    PDKTEntityDataParser *entityDataParser = [PDKTEntityDataParser dataParserForCoreDataEntity];
    NSString *entityName=NSStringFromClass([self class]);
    NSString *objectId = [self pdktmb_entityId];
    NSString *objectIdValue=[entityDataParser propertyValueForKey:objectId inDictionary:dictionary forEntityClass:[self class]];
    if (!objectIdValue) {
        return nil;
    }
    NSManagedObject *entity;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    fetchRequest.fetchLimit = 1;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%@ = %K",objectIdValue,objectId];
    
    NSArray *fetchResult=[managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    NSManagedObject *matchedObject = [fetchResult lastObject];
    if (matchedObject){
        entity = matchedObject;
    }
    if (!entity)
    {
        entity = [NSEntityDescription insertNewObjectForEntityForName:[NSString stringWithFormat:@"%@",entityName] inManagedObjectContext:managedObjectContext];
    }
    [entityDataParser parseDictionary:dictionary withEntity:(NSManagedObject<PDKTModelBuilderEntity> *)entity];
    [entityDataParser parseRelationshipsInDictionary:dictionary withEntity:(NSManagedObject<PDKTModelBuilderEntity> *)entity];
    return entity;
}
+ (instancetype)insertIntoManagedObjectContext:(NSManagedObjectContext *)managedObjectContext withDictionary:(NSDictionary *)dictionary{
    NSAssert([[self class] conformsToProtocol:@protocol(PDKTModelBuilderCoreDataEntity)], @"must implement PDKTModelBuilderCoreDataEntity for using this method");
    PDKTEntityDataParser *entityDataParser = [PDKTEntityDataParser dataParserForCoreDataEntity];
    NSString *entityName=NSStringFromClass([self class]);
    NSString *objectId = [self pdktmb_entityId];
    NSString *objectIdValue=[entityDataParser propertyValueForKey:objectId inDictionary:dictionary forEntityClass:[self class]];
    if (!objectIdValue) {
        return nil;
    }
    NSManagedObject *newObject = [NSEntityDescription insertNewObjectForEntityForName:[NSString stringWithFormat:@"%@",entityName] inManagedObjectContext:managedObjectContext];
    [entityDataParser parseDictionary:dictionary withEntity:(NSManagedObject<PDKTModelBuilderEntity> *)newObject];
    return newObject;
}
+ (instancetype)fetchObjectWithValue:(id)value forKey:(NSString *)key inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
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
+ (NSString *)pdktmb_entityId{
    NSString *entityName=NSStringFromClass([self class]);
    NSString *objectId;
    if ([self respondsToSelector:@selector(pdktmb_entityIdPropertyName)]) {
        objectId = [(id<PDKTModelBuilderCoreDataEntity>)self pdktmb_entityIdPropertyName];
    }else{
        objectId = [self defaultEntityIdPropertyNameForEntityName:entityName];
        [self validateDefaultObjectId:objectId];
    }
    return objectId.length ? objectId : nil;
}
@end

