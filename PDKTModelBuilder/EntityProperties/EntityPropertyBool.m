//
//  EntityPropertyBool.m
//
//
//  Created by Javier Soto on 03/01/12.
//

#import "EntityPropertyBool.h"

@implementation EntityPropertyBool

- (id)parsedValueForObject:(id)object
{
    if (![object respondsToSelector:@selector(boolValue)])
    {
        return [NSNumber numberWithBool:NO];
    }
    
    return [NSNumber numberWithBool:[object boolValue]];
}

@end
