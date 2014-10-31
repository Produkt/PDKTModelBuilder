//
//  EntityPropertyDouble.m
//  PDKTModelBuilder
//
//  Created by Javier Soto on 03/01/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
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
