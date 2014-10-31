//
//  EntityPropertyBool.m
//  PDKTModelBuilder
//
//  Created by Javier Soto on 03/01/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
//

#import "PDKTBoolTransformer.h"

@implementation PDKTBoolTransformer

- (id)tranformValueFromObject:(id)object
{
    if (![object respondsToSelector:@selector(boolValue)])
    {
        return [NSNumber numberWithBool:NO];
    }
    
    return [NSNumber numberWithBool:[object boolValue]];
}

@end
