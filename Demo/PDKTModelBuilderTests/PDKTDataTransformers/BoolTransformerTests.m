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
    self.boolTransformer = [[PDKTBoolTransformer alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBoolFromBoolString {
    XCTAssertEqualObjects(@YES, [self.boolTransformer parsedValueForObject:@"YES"]);
    XCTAssertEqualObjects(@NO, [self.boolTransformer parsedValueForObject:@"NO"]);
    
    XCTAssertEqualObjects(@YES, [self.boolTransformer parsedValueForObject:@"true"]);
    XCTAssertEqualObjects(@NO, [self.boolTransformer parsedValueForObject:@"false"]);
}
- (void)testBoolFromNumbers {
    XCTAssertEqualObjects(@YES, [self.boolTransformer parsedValueForObject:@"1"]);
    XCTAssertEqualObjects(@YES, [self.boolTransformer parsedValueForObject:@"2"]);
    XCTAssertEqualObjects(@NO, [self.boolTransformer parsedValueForObject:@"0"]);
    XCTAssertEqualObjects(@YES, [self.boolTransformer parsedValueForObject:@"-1"]);
}
- (void)testTransformANumberIntoABool {
    XCTAssertEqualObjects(@YES, [self.boolTransformer parsedValueForObject:@(1)]);
    XCTAssertEqualObjects(@NO, [self.boolTransformer parsedValueForObject:@(0)]);
}
- (void)testBoolFromBool {
    XCTAssertEqualObjects(@YES, [self.boolTransformer parsedValueForObject:@YES]);
    XCTAssertEqualObjects(@NO, [self.boolTransformer parsedValueForObject:@NO]);
}
@end
