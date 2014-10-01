//
//  EntityProperty.h
//
//  Created by Javier Soto on 03/01/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EntityPropertyType) {
	EntityPropertyTypeInteger,
    EntityPropertyTypeFloat,
    EntityPropertyTypeDouble,
	EntityPropertyTypeString,
	EntityPropertyTypeBool,
	EntityPropertyTypeURL,
    EntityPropertyTypeDate,
    EntityPropertyTypeTimeStamp
};

@interface EntityProperty : NSObject
+ (EntityProperty *)entityPropertyWithPropertyType:(EntityPropertyType)propertyType;
- (id)parsedValueForObject:(id)object;
@end
