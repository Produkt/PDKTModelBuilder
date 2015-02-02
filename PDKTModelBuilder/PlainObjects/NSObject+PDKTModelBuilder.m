//
//  NSObject+PDKTModelBuilder.m
//  PDKTModelBuilder
//
//  Created by Daniel García on 31/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "NSObject+PDKTModelBuilder.h"
#import "PDKTModelBuilderEntity.h"
#import "PDKTEntityDataParserFactory.h"

@implementation NSObject (PDKTModelBuilder)
+ (instancetype)objectFromDictionary:(NSDictionary *)dictionary{
    NSAssert([self conformsToProtocol:@protocol(PDKTModelBuilderEntity)], @"must implement PDKTModelBuilderEntity for using this method");
    NSObject<PDKTModelBuilderEntity> *entity = [[[self class] alloc] init];
    
    NSDictionary *sourceDictionary = dictionary;
    if ([[entity class] respondsToSelector:@selector(customDataDictionaryWithSourceDataDictionary:)]) {
        sourceDictionary = [[entity class] customDataDictionaryWithSourceDataDictionary:dictionary];
    }
    PDKTEntityDataParser *entityDataParser = [PDKTEntityDataParserFactory dataParserForPlanEntityWithDictionary:dictionary andEntity:entity];
    [entityDataParser executeDataParsing];
    return entity;
}
@end
