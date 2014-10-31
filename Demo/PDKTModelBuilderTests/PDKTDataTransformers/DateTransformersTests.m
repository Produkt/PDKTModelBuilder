//
//  DateTransformersTests.m
//  PDKTModelBuilder
//
//  Created by Daniel García on 31/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PDKTDateTransformer.h"

@interface DateTransformersTests : XCTestCase
@property (strong,nonatomic) PDKTDateTransformer *dateTransformer;
@end

@implementation DateTransformersTests

- (void)setUp {
    [super setUp];
    self.dateTransformer = [[PDKTDateTransformer alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDateFromMySQLTypeString {
    NSDate *date = [self.dateTransformer parsedValueForObject:@"2014-10-31 20:47:59"];
    XCTAssert([date isKindOfClass:[NSDate class]]);
}


@end
