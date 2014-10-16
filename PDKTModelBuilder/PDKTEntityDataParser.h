//
//  EntityDataParser.h
//  PDKTModelBuilder
//
//  Created by Daniel García García on 31/08/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDKTModelBuilderEntity.h"

@interface PDKTEntityDataParser : NSObject
- (void)parseDictionary:(NSDictionary *)dictionary withEntity:(NSObject<PDKTModelBuilderEntity> *)entity;
- (void)parseRelationshipsInDictionary:(NSDictionary *)dictionary withEntity:(NSObject<PDKTModelBuilderEntity> *)entity;
- (id)propertyValueForKey:(NSString *)key inDictionary:(NSDictionary *)dictionary forEntityClass:(Class)entityClass;
- (NSDictionary *)propertiesBindingsForEntity:(NSObject<PDKTModelBuilderEntity> *)entity;
- (NSDictionary *)propertiesTypeTransformersForEntity:(NSObject<PDKTModelBuilderEntity> *)entity;
@end
