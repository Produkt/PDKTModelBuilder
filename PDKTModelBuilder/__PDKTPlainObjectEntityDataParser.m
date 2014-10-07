//
//  __PDKTPlainObjectEntityDataParser.m
//  PDKTModelBuilderDemo
//
//  Created by Daniel García García on 07/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "__PDKTPlainObjectEntityDataParser.h"
#import "PDKTEntityRelationship.h"

@implementation __PDKTPlainObjectEntityDataParser
- (void)parseRelationshipsInDictionary:(NSDictionary *)dictionary withEntity:(NSObject<PDKTModelBuilderEntity> *)entity{
    [super parseRelationshipsInDictionary:dictionary withEntity:entity];
    NSDictionary *relationships = [[self class] relationshipsBindings];
    [relationships enumerateKeysAndObjectsUsingBlock:^(NSString *relationshipProperty, PDKTEntityRelationship *relationship, BOOL *stop) {
        [relationship parseRelationshipInDictionary:dictionary withEntity:entity relationshipProperty:relationshipProperty];
    }];
}
@end
