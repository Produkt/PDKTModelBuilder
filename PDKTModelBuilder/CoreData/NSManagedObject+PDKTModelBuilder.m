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

@implementation NSManagedObject (PDKTModelBuilder)
+ (instancetype)updateOrInsertIntoManagedObjectContext:(NSManagedObjectContext *)managedObjectContext withDictionary:(NSDictionary *)dictionary{
    NSAssert([[self class] conformsToProtocol:@protocol(PDKTModelBuilderEntity)], @"must implement PDKTModelBuilderEntity for using this method");
    NSString *entityName=NSStringFromClass([self class]);
    NSString *objectId = [self pdktmb_entityId];
    PDKTEntityDataParser *dataParser = [(id<PDKTModelBuilderEntity>)self pdktmb_dataParser];
    NSString *objectIdValue=[dataParser propertyValueForKey:objectId inDictionary:dictionary];
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
    [dataParser parseDictionary:dictionary withEntity:entity];
    return entity;
}
+ (instancetype)insertIntoManagedObjectContext:(NSManagedObjectContext *)managedObjectContext withDictionary:(NSDictionary *)dictionary{
    NSAssert([[self class] conformsToProtocol:@protocol(PDKTModelBuilderEntity)], @"must implement PDKTModelBuilderEntity for using this method");
    NSString *entityName=NSStringFromClass([self class]);
    NSString *objectId = [self pdktmb_entityId];
    PDKTEntityDataParser *dataParser = [(id<PDKTModelBuilderEntity>)self pdktmb_dataParser];
    NSString *objectIdValue=[dataParser propertyValueForKey:objectId inDictionary:dictionary];
    if (!objectIdValue) {
        return nil;
    }
    NSManagedObject *newObject = [NSEntityDescription insertNewObjectForEntityForName:[NSString stringWithFormat:@"%@",entityName] inManagedObjectContext:managedObjectContext];
    [dataParser parseDictionary:dictionary withEntity:newObject];
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
        objectId = [(id<PDKTModelBuilderEntity>)self pdktmb_entityIdPropertyName];
    }else{
        objectId = [[NSString stringWithFormat:@"%@Id",[entityName stringByReplacingOccurrencesOfString:@"Entity" withString:@""]]stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[entityName substringToIndex:1]lowercaseString]];
    }
    return objectId.length ? objectId : nil;
}
@end
