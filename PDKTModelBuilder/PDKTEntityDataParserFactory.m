//
//  PDKTEntityDataParserFactory.m
//  PDKTModelBuilderDemo
//
//  Created by Daniel García García on 16/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "PDKTEntityDataParserFactory.h"
#import "__PDKTPlainObjectEntityDataParser.h"
#import "__PDKTCoreDataEntityDataParser.h"

@implementation PDKTEntityDataParserFactory
+ (PDKTEntityDataParser *)dataParserForPlanEntity{
    return [__PDKTPlainObjectEntityDataParser new];
}
+ (PDKTEntityDataParser *)dataParserForCoreDataEntity{
    PDKTEntityDataParser *dataParser;
    dataParser = [__PDKTCoreDataEntityDataParser new];
    return dataParser;
}
@end
