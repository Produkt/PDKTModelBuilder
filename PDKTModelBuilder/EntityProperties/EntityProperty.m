//
//  EntityProperty.m
//  
//
//  Created by Javier Soto on 03/01/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
//

#import "EntityProperty.h"

#import "EntityPropertyInteger.h"
#import "EntityPropertyFloat.h"
#import "EntityPropertyBool.h"
#import "EntityPropertyString.h"
#import "EntityPropertyURL.h"
#import "EntityPropertyTimeStamp.h"

@implementation EntityProperty
+ (EntityProperty *)entityPropertyWithPropertyType:(EntityPropertyType)propertyType{
    EntityProperty *property = nil;
    switch (propertyType) {
        case EntityPropertyTypeInteger:
            property = [[EntityPropertyInteger alloc] init];
            break;
        case EntityPropertyTypeFloat:
            property = [[EntityPropertyFloat alloc] init];
            break;
        case EntityPropertyTypeBool:
            property = [[EntityPropertyBool alloc] init];
            break;
        case EntityPropertyTypeString:
            property = [[EntityPropertyString alloc] init];
            break;
        case EntityPropertyTypeURL:
            property = [[EntityPropertyURL alloc] init];
            break;
        case EntityPropertyTypeDate:
        case EntityPropertyTypeTimeStamp:
            property = [[EntityPropertyTimeStamp alloc] init];
            break;
        default:
            break;
    }
    return property;
}

- (id)parsedValueForObject:(id)object{
    // Abstract implementation
    return nil;
}

// think what would happen with recursive relationdships. Probable infinite loop. Perhaps add a maxdepth parameter for this method
- (id)randomValueWithDepth:(NSInteger)depth{
    // Abstract implementation
    return nil;
}
@end
