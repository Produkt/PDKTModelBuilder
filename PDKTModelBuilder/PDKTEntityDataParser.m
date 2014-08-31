//
//  EntityDataParser.m
//  Portfolio
//
//  Created by Daniel García García on 31/08/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "PDKTEntityDataParser.h"

static NSString * const propertyBindingSourceKeyKey = @"propertyBindingSourceKeyKey";
static NSString * const propertyBindingPropertyTypeKey = @"propertyBindingPropertyTypeKey";

@interface PDKTEntityDataParser()
@end
@implementation PDKTEntityDataParser
@dynamic propertiesBindings;
@dynamic propertiesTypeTransformers;
- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"\n\n*** '%@' selector must be implemented by the subclass %@ ***\n\n",NSStringFromSelector(aSelector),NSStringFromClass([self class]));
    [self doesNotRecognizeSelector:aSelector];
    return nil;
}
#pragma mark - Automated properties parsing
- (void)parseDictionary:(NSDictionary *)dictionary withEntity:(NSObject *)entity{
    NSDictionary *propertiesBindings = @{};
    if ([self respondsToSelector:@selector(propertiesBindings)]) {
        propertiesBindings = self.propertiesBindings;
    }
    NSDictionary *propertiesTypeTransformers = @{};
    if ([self respondsToSelector:@selector(propertiesTypeTransformers)]) {
        propertiesTypeTransformers = self.propertiesTypeTransformers;
    }
    [propertiesBindings enumerateKeysAndObjectsUsingBlock:^(NSString *entityPropertyName, NSString *sourcePath, BOOL *stop) {
        id propertyValue = [self propertyValueForKey:entityPropertyName sourcePath:sourcePath inDictionary:dictionary withTransformers:propertiesTypeTransformers];
        if (propertyValue) {
            [self setValue:propertyValue forKey:entityPropertyName];
        }
    }];
}
- (id)propertyValueForKey:(NSString *)key inDictionary:(NSDictionary *)dictionary{
    NSDictionary *propertiesBindings = @{};
    if ([self respondsToSelector:@selector(propertiesBindings)]) {
        propertiesBindings = self.propertiesBindings;
    }
    NSString *sourcePath = [propertiesBindings valueForKey:key];
    NSDictionary *propertiesTypeTransformers = @{};
    if ([self respondsToSelector:@selector(propertiesTypeTransformers)]) {
        propertiesTypeTransformers = self.propertiesTypeTransformers;
    }
    return [self propertyValueForKey:key sourcePath:sourcePath inDictionary:dictionary withTransformers:propertiesTypeTransformers];
}
- (id)propertyValueForKey:(NSString *)key sourcePath:(NSString *)sourcePath inDictionary:(NSDictionary *)dictionary withTransformers:(NSDictionary *)propertiesTypeTransformers{
    id propertyValue;
    id rawValue = [dictionary valueForKeyPath:sourcePath];
    if (![rawValue isKindOfClass:[NSNull class]]) {
        EntityPropertyType propertyType = [[propertiesTypeTransformers valueForKey:key]?:@(EntityPropertyTypeString) integerValue];
        EntityProperty *entityProperty=[EntityProperty entityPropertyWithPropertyType:propertyType];
        propertyValue=[entityProperty parsedValueForObject:rawValue];
    }
    return propertyValue;
}
@end
