//
//  NSObjectModelsTests.m
//  PDKTModelBuilder
//
//  Created by Daniel García on 31/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSObject+PDKTModelBuilder.h"
#import "TestablePicture.h"
#import "TestablePicture+PDKTModelBuilderEntity.h"

@interface NSObjectModelsTests : XCTestCase

@end

@implementation NSObjectModelsTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testObjectAutocreation {
    NSDictionary *pictureInfo = @{
                                  @"id":@"1",
                                  @"url":@"http://www.apple.com",
                                  @"rating":@"3.5",
                                  @"published_on":@"2014-10-31 20:47:59"
                                  };
    TestablePicture *picture = [TestablePicture newObjectFromDictionary:pictureInfo];
    XCTAssertNotNil(picture);
    XCTAssert([picture isKindOfClass:[TestablePicture class]]);
    XCTAssertEqualObjects(picture.pictureId, @"1");
    XCTAssertEqualObjects(picture.pictureURL, [NSURL URLWithString:@"http://www.apple.com"]);
    XCTAssertEqualObjects(picture.pictureRating, @(3.5));
    XCTAssertEqualObjects(picture.picturePublishedDate, [NSDate dateWithTimeIntervalSince1970:1414784879]);
}

- (void)testIncompleteObjectAutocreation{
    NSDictionary *pictureInfo = @{
                                  @"url":@"http://www.apple.com",
                                  @"published_on":@"2014-10-31 20:47:59"
                                  };
    TestablePicture *picture = [TestablePicture newObjectFromDictionary:pictureInfo];
    XCTAssertNotNil(picture);
    XCTAssert([picture isKindOfClass:[TestablePicture class]]);
    XCTAssertNil(picture.pictureId);
    XCTAssertEqualObjects(picture.pictureURL, [NSURL URLWithString:@"http://www.apple.com"]);
    XCTAssertNil(picture.pictureRating);
    XCTAssertEqualObjects(picture.picturePublishedDate, [NSDate dateWithTimeIntervalSince1970:1414784879]);
}

@end
