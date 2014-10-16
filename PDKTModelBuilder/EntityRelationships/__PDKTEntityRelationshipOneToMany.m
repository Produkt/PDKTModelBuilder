//
//  PDKTEntityRelationshipOneToMany.m
//  PDKTModelBuilder
//
//  Created by Daniel García García on 06/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "__PDKTEntityRelationshipOneToMany.h"

@implementation __PDKTEntityRelationshipOneToMany
- (void)parseRelationshipInDictionary:(NSDictionary *)dictionary withEntity:(NSObject *)entity relationshipProperty:(NSString *)relationshipProperty{
    id relationshipData = [dictionary valueForKeyPath:self.keyPath];
    if ([relationshipData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *relationshipItem in relationshipData) {
            id item = [self parseItemData:relationshipItem withClass:self.relatedClass];
            if (item) {
                [self addItem:item toEntity:entity toColletionInPropertyWithName:relationshipProperty];
            }
        }
    }else{
        id item = [self parseItemData:relationshipData withClass:self.relatedClass];
        if (item) {
            [entity setValue:item forKey:relationshipProperty];
        }
    }
}
- (id)parseItemData:(NSDictionary *)itemData withClass:(Class)itemClass {
    return nil;
}
- (void)addItem:(id)item toEntity:(NSObject *)entity toColletionInPropertyWithName:(NSString *)relationshipPropertyName{
    id collection = [entity valueForKey:relationshipPropertyName];
    if ([collection isKindOfClass:[NSMutableArray class]]) {
        NSMutableArray *relationship = (NSMutableArray *)collection;
        if (![relationship containsObject:item]) {
            [relationship addObject:item];
        }
    }else if ([collection isKindOfClass:[NSMutableSet class]]){
        NSMutableSet *relationship = (NSMutableSet *)collection;
        if (![relationship containsObject:item]) {
            [relationship addObject:item];
        }
    }
}
@end
