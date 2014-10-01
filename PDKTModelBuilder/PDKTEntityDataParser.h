//
//  EntityDataParser.h
//  Portfolio
//
//  Created by Daniel García García on 31/08/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityProperties.h"

@interface PDKTEntityDataParser : NSObject
@property (nonatomic, readonly) NSDictionary *propertiesBindings;
@property (nonatomic, readonly) NSDictionary *propertiesTypeTransformers;
- (void)parseDictionary:(NSDictionary *)dictionary withEntity:(NSObject *)entity;
- (id)propertyValueForKey:(NSString *)key inDictionary:(NSDictionary *)dictionary;
@end
