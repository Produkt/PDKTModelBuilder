//
//  EntityPropertyFloat.m
//  
//
//  Created by Javier Soto on 1/4/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
//

#import "EntityPropertyFloat.h"

@implementation EntityPropertyFloat

- (id)parsedValueForObject:(id)object
{
    if (![object respondsToSelector:@selector(floatValue)])
    {
        return [NSNumber numberWithFloat:0];
    }
    
    return [NSNumber numberWithFloat:[object floatValue]];
}

@end
