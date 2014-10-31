//
//  TestablePicture+PDKTModelBuilderEntity.m
//  PDKTModelBuilder
//
//  Created by Daniel García on 31/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "TestablePicture+PDKTModelBuilderEntity.h"

@implementation TestablePicture (PDKTModelBuilderEntity)
+ (NSDictionary *)propertiesBindings{
    return @{
             @"pictureId":@"id",
             @"pictureURL":@"url",
             @"pictureRating":@"rating",
             @"picturePublishedDate":@"published_on"
             };
}
@end
