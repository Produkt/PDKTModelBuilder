//
//  PDKTCoreDataEntityDataParserFactory.m
//  PDKTModelBuilder
//
//  Created by Daniel García on 02/02/15.
//  Copyright (c) 2015 Produkt. All rights reserved.
//

#import "PDKTCoreDataEntityDataParserFactory.h"
#import "__PDKTCoreDataEntityDataParser.h"

@implementation PDKTCoreDataEntityDataParserFactory
+ (PDKTEntityDataParser *)dataParserForCoreDataEntityWithDictionary:(NSDictionary *)dictionary andEntity:(NSObject<PDKTModelBuilderEntity> *)entity{
    PDKTEntityDataParser *dataParser;
    dataParser = [[__PDKTCoreDataEntityDataParser alloc]initWithDictionary:dictionary andEntity:entity];
    return dataParser;
}
@end
