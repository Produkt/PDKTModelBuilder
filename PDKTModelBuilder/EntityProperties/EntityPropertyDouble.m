//
//  EntityPropertyDouble.m
//
//
//  Created by Daniel García García on 01/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "EntityPropertyDouble.h"

@implementation EntityPropertyDouble

- (id)parsedValueForObject:(id)object
{
    if (![object respondsToSelector:@selector(doubleValue)])
    {
        return [NSNumber numberWithDouble:0];
    }
    
    return [NSNumber numberWithDouble:[object doubleValue]];
}

@end
