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
- (BOOL)executeDataParsing{
    BOOL isExecuteEntityParsing = NO;
    if ([self entity:self.entity needsParsingWithDictionary:self.dictionary]) {
        [self parseDictionary:self.dictionary withEntity:self.entity];
        isExecuteEntityParsing = YES;
    }
    [self parseRelationshipsInDictionary:self.dictionary withEntity:self.entity];
    return isExecuteEntityParsing;
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

#pragma mark - Private Methods
- (BOOL)entity:(NSObject<PDKTModelBuilderEntity> *)entity needsParsingWithDictionary:(NSDictionary *)dictionary {
    BOOL entityNeedsParsing = YES;
    NSString *attributeName;
    if ([[entity class] respondsToSelector:@selector(comparableAttribute)]) {
        attributeName = [[entity class] comparableAttribute];
    }
    if (attributeName) {
        id apiAttributeValue = [[self class] propertyValueForKey:attributeName inDictionary:dictionary forEntityClass:[entity class]];
        if (apiAttributeValue) {
            id entityComparableAttribute = [entity valueForKey:attributeName];
            if ([apiAttributeValue respondsToSelector:@selector(compare:)] && [entityComparableAttribute respondsToSelector:@selector(compare:)]) {
                if ([apiAttributeValue compare:entityComparableAttribute] == NSOrderedSame) {
                    entityNeedsParsing = NO;
                }
            }
        }
    }
    return entityNeedsParsing;
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
    if (rawValue && ![rawValue isKindOfClass:[NSNull class]]) {
        PDKTDataTransformer *entityProperty=[propertiesTypeTransformers valueForKey:key]?:[PDKTStringTransformer new];
        propertyValue=[entityProperty tranformValueFromObject:rawValue];
    }
    return propertyValue;
}
@end
