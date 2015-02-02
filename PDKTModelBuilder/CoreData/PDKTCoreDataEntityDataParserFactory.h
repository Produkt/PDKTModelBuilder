//
//  PDKTCoreDataEntityDataParserFactory.h
//  PDKTModelBuilder
//
//  Created by Daniel García on 02/02/15.
//  Copyright (c) 2015 Produkt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDKTEntityDataParser.h"

@interface PDKTCoreDataEntityDataParserFactory : NSObject
+ (PDKTEntityDataParser *)dataParserForCoreDataEntityWithDictionary:(NSDictionary *)dictionary andEntity:(NSObject<PDKTModelBuilderEntity> *)entity;
@end
