//
//  StringTranformerTests.m
//  PDKTModelBuilder
//
//  Created by Daniel García on 31/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PDKTStringTransformer.h"

@interface StringTranformerTests : XCTestCase
@property (strong,nonatomic) PDKTStringTransformer *stringTransformer;
@end

@implementation StringTranformerTests

- (void)setUp {
    [super setUp];
    self.stringTransformer = [PDKTStringTransformer new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testReturnsAString {
    XCTAssert([[self.stringTransformer tranformValueFromObject:@"..."] isKindOfClass:[NSString class]]);
}

- (void)testStringFromNilObjects {
    XCTAssertEqualObjects([self.stringTransformer tranformValueFromObject:nil], @"");
    XCTAssertEqualObjects([self.stringTransformer tranformValueFromObject:[NSNull null]], @"");
}

- (void)testStringFromString {
    XCTAssertEqualObjects([self.stringTransformer tranformValueFromObject:@"..."], @"...");
}

- (void)testStringFromObjectsDescription {
    XCTAssertEqualObjects([self.stringTransformer tranformValueFromObject:[NSURL URLWithString:@"http://www.apple.com"]], @"http://www.apple.com");
}

@end
