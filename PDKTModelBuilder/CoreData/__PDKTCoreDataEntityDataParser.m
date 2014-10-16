//
//  PDKTCoreDataEntityDataParser.m
//  PDKTModelBuilder
//
//  Created by Daniel García García on 07/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "__PDKTCoreDataEntityDataParser.h"
#import "PDKTCoreDataEntityRelationship.h"
#import <objc/runtime.h>

@implementation __PDKTCoreDataEntityDataParser
- (NSDictionary *)propertiesBindingsForEntity:(NSObject<PDKTModelBuilderEntity> *)entity{
    NSMutableDictionary *propertiesBindings = [[super propertiesBindingsForEntity:entity] mutableCopy];
    [self loadPropertiesBindingsForClass:[entity class] inPropertiesBindingsMutableDictionary:propertiesBindings];
    return propertiesBindings;
}
- (void)loadPropertiesBindingsForClass:(Class)entityClass inPropertiesBindingsMutableDictionary:(NSMutableDictionary *)propertiesBindings{
    Class superClass = class_getSuperclass(entityClass);
    if (superClass != [NSManagedObject class]) {
        [self loadPropertiesBindingsForClass:superClass inPropertiesBindingsMutableDictionary:propertiesBindings];
    }
    if ([entityClass respondsToSelector:@selector(propertiesBindings)]) {
        [propertiesBindings addEntriesFromDictionary:[entityClass propertiesBindings]];
    }
}
- (NSDictionary *)propertiesTypeTransformersForEntity:(NSObject<PDKTModelBuilderEntity> *)entity{
    NSMutableDictionary *propertiesTypeTransformers = [[super propertiesTypeTransformersForEntity:entity] mutableCopy];
    [self loadPropertiesTypeTransformersForClass:[entity class] inPropertiesTypeTransformersMutableDictionary:propertiesTypeTransformers];
    return propertiesTypeTransformers;
}
- (void)loadPropertiesTypeTransformersForClass:(Class)entityClass inPropertiesTypeTransformersMutableDictionary:(NSMutableDictionary *)propertiesTypeTransformers{
    Class superClass = class_getSuperclass(entityClass);
    if (superClass != [NSManagedObject class]) {
        [self loadPropertiesTypeTransformersForClass:superClass inPropertiesTypeTransformersMutableDictionary:propertiesTypeTransformers];
    }
    if ([entityClass respondsToSelector:@selector(propertiesBindings)]) {
        [propertiesTypeTransformers addEntriesFromDictionary:[entityClass propertiesTypeTransformers]];
    }
}
- (void)parseRelationshipsInDictionary:(NSDictionary *)dictionary withEntity:(NSManagedObject<PDKTModelBuilderEntity> *)entity{
    [super parseRelationshipsInDictionary:dictionary withEntity:entity];
    if ([[entity class] respondsToSelector:@selector(relationshipsBindings)]) {
        NSDictionary *relationships = [[entity class] relationshipsBindings];
        [relationships enumerateKeysAndObjectsUsingBlock:^(NSString *relationshipProperty, PDKTCoreDataEntityRelationship *relationship, BOOL *stop) {
            [relationship parseRelationshipInDictionary:dictionary withEntity:entity relationshipProperty:relationshipProperty inManagedObjectContext:entity.managedObjectContext];
        }];
    }
}
@end
