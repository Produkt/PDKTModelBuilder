//
//  EntityPropertyTimeStamp.m
//  PDKTModelBuilder
//
//  Created by Ruben Mendez Puente on 17/05/12.
//  Copyright (c) 2012 minube.com. All rights reserved.
//

#import "PDKTDateTransformer.h"

@implementation PDKTDateTransformer

- (id)parsedValueForObject:(id)object
{
    if (!object || [object isEqual:[NSNull null]])
    {
        return nil;
    }
    NSString *objectDescription=[NSString stringWithFormat:@"%@", object];
    NSDate *date=nil;
    NSCharacterSet *alphaNumbersSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:objectDescription];
    if ([alphaNumbersSet isSupersetOfSet:stringSet]) {
        date = [NSDate dateWithTimeIntervalSince1970:[objectDescription integerValue]];
    }else{
        static dispatch_once_t onceToken;
        static NSDateFormatter *entyPropertyDateFormatter;
        dispatch_once(&onceToken, ^{
            NSDateFormatter *entyPropertyDateFormatter = [[NSDateFormatter alloc] init];
            [entyPropertyDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        });
        date = [entyPropertyDateFormatter dateFromString:objectDescription];
    }
    return date;
}

@end
