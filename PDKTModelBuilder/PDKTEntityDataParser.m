//
//  EntityDataParser.m
//  Portfolio
//
//  Created by Daniel García García on 31/08/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "PDKTEntityDataParser.h"
#import "EntityProperties.h"
#import "__PDKTPlainObjectEntityDataParser.h"
#import "__PDKTCoreDataEntityDataParser.h"

@interface PDKTEntityDataParser()
@end
@implementation PDKTEntityDataParser
+ (instancetype)dataParserForPlanEntity{
    return [__PDKTPlainObjectEntityDataParser new];
}
+ (instancetype)dataParserForCoreDataEntity{
    PDKTEntityDataParser *dataParser;
    dataParser = [__PDKTCoreDataEntityDataParser new];
    return dataParser;
}
- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}
#pragma mark - Automated properties parsing
- (void)parseDictionary:(NSDictionary *)dictionary withEntity:(NSObject<PDKTModelBuilderEntity> *)entity{
    NSDictionary *propertiesBindings = @{};
    if ([[entity class] respondsToSelector:@selector(propertiesBindings)]) {
        propertiesBindings = [[entity class] propertiesBindings];
    }
    NSDictionary *propertiesTypeTransformers = @{};
    if ([[entity class] respondsToSelector:@selector(propertiesTypeTransformers)]) {
        propertiesTypeTransformers = [[entity class] propertiesTypeTransformers];
    }
    [propertiesBindings enumerateKeysAndObjectsUsingBlock:^(NSString *entityPropertyName, NSString *sourcePath, BOOL *stop) {
        id propertyValue = [self propertyValueForKey:entityPropertyName sourcePath:sourcePath inDictionary:dictionary withTransformers:propertiesTypeTransformers];
        if (propertyValue) {
            [entity setValue:propertyValue forKey:entityPropertyName];
        }
    }];
}
- (id)propertyValueForKey:(NSString *)key inDictionary:(NSDictionary *)dictionary forEntityClass:(Class)entityClass{
    NSAssert([entityClass conformsToProtocol:@protocol(PDKTModelBuilderEntity)], @"entityClass must conform PDKTModelBuilderEntity");
    NSDictionary *propertiesBindings = @{};
    if ([entityClass respondsToSelector:@selector(propertiesBindings)]) {
        propertiesBindings = [entityClass propertiesBindings];
    }
    NSString *sourcePath = [propertiesBindings valueForKey:key];
    NSDictionary *propertiesTypeTransformers = @{};
    if ([entityClass respondsToSelector:@selector(propertiesTypeTransformers)]) {
        propertiesTypeTransformers = [entityClass propertiesTypeTransformers];
    }
    return [self propertyValueForKey:key sourcePath:sourcePath inDictionary:dictionary withTransformers:propertiesTypeTransformers];
}
- (id)propertyValueForKey:(NSString *)key sourcePath:(NSString *)sourcePath inDictionary:(NSDictionary *)dictionary withTransformers:(NSDictionary *)propertiesTypeTransformers{
    id propertyValue;
    id rawValue = [dictionary valueForKeyPath:sourcePath];
    if (![rawValue isKindOfClass:[NSNull class]]) {
        EntityProperty *entityProperty=[propertiesTypeTransformers valueForKey:key]?:[EntityPropertyString new];
        propertyValue=[entityProperty parsedValueForObject:rawValue];
    }
    return propertyValue;
}
- (void)parseRelationshipsInDictionary:(NSDictionary *)dictionary withEntity:(NSObject<PDKTModelBuilderEntity> *)entity{
    
}
@end
