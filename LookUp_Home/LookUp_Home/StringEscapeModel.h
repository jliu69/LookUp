//
//  StringEscapeModel.h
//  LookUp
//
//  Created by Johnson Liu on 10/4/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringEscapeModel : NSObject

+ (NSString *)queryAndUrlEscapeText:(NSString *)text;

@end
