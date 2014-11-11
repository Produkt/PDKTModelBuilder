//
//  PictureEntity.h
//  PDKTModelBuilder
//
//  Created by Daniel García García on 11/11/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UserEntity;

@interface PictureEntity : NSManagedObject

@property (nonatomic, retain) NSString * pictureId;
@property (nonatomic, retain) NSDate * picturePublishedDate;
@property (nonatomic, retain) id pictureURL;
@property (nonatomic, retain) UserEntity *author;

@end
