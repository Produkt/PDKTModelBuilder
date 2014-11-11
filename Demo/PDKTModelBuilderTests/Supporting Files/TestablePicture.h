//
//  TestablePicture.h
//  PDKTModelBuilder
//
//  Created by Daniel García on 31/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestablePicture : NSObject
@property (copy, nonatomic) NSString *pictureId;
@property (copy, nonatomic) NSURL *pictureURL;
@property (strong, nonatomic) NSNumber *pictureRating;
@property (strong, nonatomic) NSDate *picturePublishedDate;
@end
