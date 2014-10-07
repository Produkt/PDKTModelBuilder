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
    id item = [self parseItemData:dictionary withClass:self.relatedClass inManagedObjectContext:managedObjectContext];
    if (item) {
        [entity setValue:item forKey:relationshipProperty];
    }
}
- (id)parseItemData:(NSDictionary *)itemData withClass:(Class)itemClass inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    return [itemClass updateOrInsertIntoManagedObjectContext:managedObjectContext withDictionary:itemData];
}
@end
