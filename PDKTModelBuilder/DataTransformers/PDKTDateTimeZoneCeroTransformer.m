//
//  PDKTDateTimeZoneCeroTransformer.m
//  PDKTModelBuilder
//
//  Created by Antonio on 17/1/16.
//  Copyright © 2016 Produkt. All rights reserved.
//

#import "PDKTDateTimeZoneCeroTransformer.h"

@implementation PDKTDateTimeZoneCeroTransformer

- (id)tranformValueFromObject:(id)object {
    if (!object || [object isEqual:[NSNull null]]) {
        return nil;
    }
    NSString *objectDescription = [NSString stringWithFormat:@"%@", object];
    NSDate *date = nil;
    NSCharacterSet *alphaNumbersSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:objectDescription];
    if ([alphaNumbersSet isSupersetOfSet:stringSet]) {
        date = [NSDate dateWithTimeIntervalSince1970:[objectDescription integerValue]];
    } else {
        static dispatch_once_t onceToken;
        static NSDateFormatter *entyPropertyDateFormatter;
        dispatch_once(&onceToken, ^{
            entyPropertyDateFormatter = [[NSDateFormatter alloc] init];
            entyPropertyDateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            [entyPropertyDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
        });
        date = [entyPropertyDateFormatter dateFromString:objectDescription];
    }
    return date;
}

@end
