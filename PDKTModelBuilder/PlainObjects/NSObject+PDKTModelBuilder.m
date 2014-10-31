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
+ (instancetype)newObjectFromDictionary:(NSDictionary *)dictionary{
    NSAssert([self conformsToProtocol:@protocol(PDKTModelBuilderEntity)], @"must implement PDKTModelBuilderEntity for using this method");
    NSObject<PDKTModelBuilderEntity> *entity = [[[self class] alloc] init];
    PDKTEntityDataParser *entityDataParser = [PDKTEntityDataParserFactory dataParserForPlanEntity];
    [entityDataParser parseDictionary:dictionary withEntity:entity];
    [entityDataParser parseRelationshipsInDictionary:dictionary withEntity:entity];
    return entity;
}
@end
