//
//  URLTransformerTests.m
//  PDKTModelBuilder
//
//  Created by Daniel García on 31/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PDKTURLTransformer.h"

@interface URLTransformerTests : XCTestCase
@property (strong,nonatomic) PDKTURLTransformer *urlTransformer;
@end

@implementation URLTransformerTests

- (void)setUp {
    [super setUp];
    self.urlTransformer = [PDKTURLTransformer new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testReturnsAURL {
    XCTAssert([[self.urlTransformer tranformValueFromObject:@"apple.com"] isKindOfClass:[NSURL class]]);
}

- (void)testValidURLFromString {
    XCTAssertEqualObjects([self.urlTransformer tranformValueFromObject:@"www.apple.com"], [NSURL URLWithString:@"www.apple.com"]);
    XCTAssertEqualObjects([self.urlTransformer tranformValueFromObject:@"apple.com"], [NSURL URLWithString:@"apple.com"]);
    XCTAssertEqualObjects([self.urlTransformer tranformValueFromObject:@"http://www.apple.com"], [NSURL URLWithString:@"http://www.apple.com"]);
    XCTAssertEqualObjects([self.urlTransformer tranformValueFromObject:@"https://www.apple.com"], [NSURL URLWithString:@"https://www.apple.com"]);
}

- (void)testInvalidURLFromString {
    XCTAssertNil([self.urlTransformer tranformValueFromObject:@"invalid url"]);
    XCTAssertNil([self.urlTransformer tranformValueFromObject:@"http://www"]);
}
@end
