//
//  __PDKTCoreDataEntityRelationshipOneToOne.m
//  PDKTModelBuilder
//
//  Created by Daniel García García on 07/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "__PDKTCoreDataEntityRelationshipOneToOne.h"

@implementation __PDKTCoreDataEntityRelationshipOneToOne
- (void)parseRelationshipInDictionary:(NSDictionary *)dictionary withEntity:(NSManagedObject *)entity relationshipProperty:(NSString *)relationshipProperty inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    id relationshipData = [dictionary valueForKeyPath:self.keyPath];
    if ([relationshipData isKindOfClass:[NSDictionary class]]) {
        id item = [self parseItemData:relationshipData withClass:self.relatedClass inManagedObjectContext:managedObjectContext];
        if (item) {
            [entity setValue:item forKey:relationshipProperty];
        }
    } else if (!relationshipData || [relationshipData isEqual:[NSNull null]]) {
        [entity setValue:nil forKey:relationshipProperty];
    }
}
- (id)parseItemData:(NSDictionary *)itemData withClass:(Class)itemClass inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    return [itemClass updateOrInsertIntoManagedObjectContext:managedObjectContext withDictionary:itemData];
}
@end
