//
//  BoolTransformerTests.m
//  PDKTModelBuilder
//
//  Created by Daniel García on 31/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PDKTBoolTransformer.h"

@interface BoolTransformerTests : XCTestCase
@property (strong,nonatomic) PDKTBoolTransformer *boolTransformer;
@end

@implementation BoolTransformerTests

- (void)setUp {
    [super setUp];
    self.boolTransformer = [PDKTBoolTransformer new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testReturnsABool {
    XCTAssert([[self.boolTransformer tranformValueFromObject:@"YES"] isKindOfClass:NSClassFromString(@"__NSCFBoolean")]);
}

- (void)testBoolFromBoolString {
    XCTAssertEqualObjects(@NO, [self.boolTransformer tranformValueFromObject:@""]);
    
    XCTAssertEqualObjects(@YES, [self.boolTransformer tranformValueFromObject:@"YES"]);
    XCTAssertEqualObjects(@NO, [self.boolTransformer tranformValueFromObject:@"NO"]);
    
    XCTAssertEqualObjects(@YES, [self.boolTransformer tranformValueFromObject:@"true"]);
    XCTAssertEqualObjects(@NO, [self.boolTransformer tranformValueFromObject:@"false"]);
}
- (void)testBoolFromNumbers {
    XCTAssertEqualObjects(@YES, [self.boolTransformer tranformValueFromObject:@"1"]);
    XCTAssertEqualObjects(@YES, [self.boolTransformer tranformValueFromObject:@"2"]);
    XCTAssertEqualObjects(@NO, [self.boolTransformer tranformValueFromObject:@"0"]);
    XCTAssertEqualObjects(@YES, [self.boolTransformer tranformValueFromObject:@"-1"]);
}
- (void)testTransformANumberIntoABool {
    XCTAssertEqualObjects(@YES, [self.boolTransformer tranformValueFromObject:@(1)]);
    XCTAssertEqualObjects(@NO, [self.boolTransformer tranformValueFromObject:@(0)]);
}
- (void)testBoolFromBool {
    XCTAssertEqualObjects(@YES, [self.boolTransformer tranformValueFromObject:@YES]);
    XCTAssertEqualObjects(@NO, [self.boolTransformer tranformValueFromObject:@NO]);
}
@end
