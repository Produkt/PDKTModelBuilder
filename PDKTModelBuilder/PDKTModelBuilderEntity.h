//
//  PDKTModelBuilderEntity.h
//  PDKTModelBuilder
//
//  Created by Daniel García García on 30/09/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PDKTModelBuilderEntity <NSObject>
+ (NSDictionary *)propertiesBindings;
@optional
+ (NSDictionary *)relationshipsBindings;
+ (NSDictionary *)propertiesTypeTransformers;
+ (NSDictionary *)customDataDictionaryWithSourceDataDictionary:(NSDictionary *)dictionary;
+ (NSString *)comparableUnixTimestampAttribute;
@end
