//
//  EntityPropertyString.m
//  PDKTModelBuilder
//
//  Created by Javier Soto on 03/01/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
//


#import "PDKTStringTransformer.h"

@implementation PDKTStringTransformer

- (id)tranformValueFromObject:(id)object
{
    if (!object || [object isEqual:[NSNull null]])
    {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%@", object];
}

@end
