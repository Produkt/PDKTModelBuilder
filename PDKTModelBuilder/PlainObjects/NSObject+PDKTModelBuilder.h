//
//  NSObject+PDKTModelBuilder.h
//  PDKTModelBuilder
//
//  Created by Daniel García on 31/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PDKTModelBuilder)
+ (instancetype)objectFromDictionary:(NSDictionary *)dictionary;
@end
