//
//  PDKTEntityDataParserFactory.h
//  PDKTModelBuilder
//
//  Created by Daniel García García on 16/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDKTEntityDataParser.h"

@interface PDKTEntityDataParserFactory : NSObject
+ (PDKTEntityDataParser *)dataParserForPlanEntity;
+ (PDKTEntityDataParser *)dataParserForCoreDataEntity;
@end
