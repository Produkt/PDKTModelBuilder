//
//  EntityPropertyTypeInt.m
//  PDKTModelBuilder
//
//  Created by Javier Soto on 03/01/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
//

#import "EntityPropertyInteger.h"

@implementation EntityPropertyInteger

- (id)parsedValueForObject:(id)object
{
    if (![object respondsToSelector:@selector(intValue)])
    {
        return [NSNumber numberWithInt:0];
    }
    
    return [NSNumber numberWithInt:[object intValue]];
}

@end
