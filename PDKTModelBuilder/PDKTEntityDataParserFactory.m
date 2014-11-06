//
//  PDKTEntityDataParserFactory.m
//  PDKTModelBuilder
//
//  Created by Daniel García García on 16/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "PDKTEntityDataParserFactory.h"
#import "__PDKTPlainObjectEntityDataParser.h"
#import "__PDKTCoreDataEntityDataParser.h"

@implementation PDKTEntityDataParserFactory
+ (PDKTEntityDataParser *)dataParserForPlanEntityWithDictionary:(NSDictionary *)dictionary andEntity:(NSObject<PDKTModelBuilderEntity> *)entity{
    return [[__PDKTPlainObjectEntityDataParser alloc]initWithDictionary:dictionary andEntity:entity];
}
+ (PDKTEntityDataParser *)dataParserForCoreDataEntityWithDictionary:(NSDictionary *)dictionary andEntity:(NSObject<PDKTModelBuilderEntity> *)entity{
    PDKTEntityDataParser *dataParser;
    dataParser = [[__PDKTCoreDataEntityDataParser alloc]initWithDictionary:dictionary andEntity:entity];
    return dataParser;
}
@end
