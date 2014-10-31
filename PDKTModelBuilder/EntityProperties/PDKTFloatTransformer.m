//
//  EntityPropertyFloat.m
//  PDKTModelBuilder
//
//  Created by Javier Soto on 03/01/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
//

#import "PDKTFloatTransformer.h"

@implementation PDKTFloatTransformer

- (id)parsedValueForObject:(id)object
{
    if (![object respondsToSelector:@selector(floatValue)])
    {
        return [NSNumber numberWithFloat:0];
    }
    
    return [NSNumber numberWithFloat:[object floatValue]];
}

@end
