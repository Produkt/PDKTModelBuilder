//
//  PDKTModelBuilderEntity.h
//  PDKTModelBuilderDemo
//
//  Created by Daniel García García on 30/09/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDKTEntityDataParser.h"

@protocol PDKTModelBuilderEntity <NSObject>
+ (PDKTEntityDataParser *)pdktmb_dataParser;
@end
