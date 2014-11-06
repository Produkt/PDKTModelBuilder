//
//  EntityDataParser.m
//  PDKTModelBuilder
//
//  Created by Daniel García García on 31/08/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "PDKTEntityDataParser.h"
#import "PDKTDataTransformers.h"

@interface PDKTEntityDataParser(_PropertyParse)
+ (id)propertyValueForKey:(NSString *)key sourcePath:(NSString *)sourcePath inDictionary:(NSDictionary *)dictionary withTransformers:(NSDictionary *)propertiesTypeTransformers;
@end

@interface PDKTEntityDataParser()
@property (strong,nonatomic) NSObject<PDKTModelBuilderEntity> *entity;
@property (strong,nonatomic) NSDictionary *dictionary;
@end
@implementation PDKTEntityDataParser
- (instancetype)initWithDictionary:(NSDictionary *)dictionary andEntity:(NSObject<PDKTModelBuilderEntity> *)entity
{
    self = [super init];
    if (self) {
        self.entity = entity;
        self.dictionary = [self sourceDictionaryWithDictionary:dictionary forEntity:entity];
    }
    return self;
}
- (NSDictionary *)sourceDictionaryWithDictionary:(NSDictionary *)dictionary forEntity:(NSObject<PDKTModelBuilderEntity> *)entity{
    NSDictionary *sourceDictionary = dictionary;
    if ([[entity class] respondsToSelector:@selector(customDataDictionaryWithSourceDataDictionary:)]) {
        sourceDictionary = [[entity class] customDataDictionaryWithSourceDataDictionary:dictionary];
    }
    return sourceDictionary;
}
- (void)executeDataParsing{
    [self parseDictionary:self.dictionary withEntity:self.entity];
    [self parseRelationshipsInDictionary:self.dictionary withEntity:self.entity];
}
#pragma mark - Automated properties parsing
- (void)parseDictionary:(NSDictionary *)dictionary withEntity:(NSObject<PDKTModelBuilderEntity> *)entity{
    NSDictionary *propertiesBindings = [[self class] propertiesBindingsForEntity:entity];
    NSDictionary *propertiesTypeTransformers = [[self class] propertiesTypeTransformersForEntity:entity];
    [propertiesBindings enumerateKeysAndObjectsUsingBlock:^(NSString *entityPropertyName, NSString *sourcePath, BOOL *stop) {
        id propertyValue = [[self class] propertyValueForKey:entityPropertyName sourcePath:sourcePath inDictionary:dictionary withTransformers:propertiesTypeTransformers];
        if (propertyValue) {
            [entity setValue:propertyValue forKey:entityPropertyName];
        }
    }];
}
- (void)parseRelationshipsInDictionary:(NSDictionary *)dictionary withEntity:(NSObject<PDKTModelBuilderEntity> *)entity{
    
}
@end


@implementation PDKTEntityDataParser(PropertyParse)
+ (NSDictionary *)propertiesBindingsForEntity:(NSObject<PDKTModelBuilderEntity> *)entity{
    return @{};
}
+ (NSDictionary *)propertiesTypeTransformersForEntity:(NSObject<PDKTModelBuilderEntity> *)entity{
    return @{};
}
+ (id)propertyValueForKey:(NSString *)key inDictionary:(NSDictionary *)dictionary forEntityClass:(Class)entityClass{
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
+ (id)propertyValueForKey:(NSString *)key sourcePath:(NSString *)sourcePath inDictionary:(NSDictionary *)dictionary withTransformers:(NSDictionary *)propertiesTypeTransformers{
    id propertyValue;
    id rawValue = [dictionary valueForKeyPath:sourcePath];
    if (![rawValue isKindOfClass:[NSNull class]]) {
        PDKTDataTransformer *entityProperty=[propertiesTypeTransformers valueForKey:key]?:[PDKTStringTransformer new];
        propertyValue=[entityProperty tranformValueFromObject:rawValue];
    }
    return propertyValue;
}
@end