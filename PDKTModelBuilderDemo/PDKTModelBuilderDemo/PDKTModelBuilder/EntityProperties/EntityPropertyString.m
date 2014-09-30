//
//  EntityPropertyString.m
//  
//
//  Created by Javier Soto on 03/01/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
//

#import "EntityPropertyString.h"

#define kRandomValueLength 15

@implementation EntityPropertyString

- (id)parsedValueForObject:(id)object
{
    if (!object || [object isEqual:[NSNull null]])
    {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%@", object];
}

@end
