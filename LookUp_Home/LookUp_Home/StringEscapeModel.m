//
//  StringEscapeModel.m
//  LookUp
//
//  Created by Johnson Liu on 10/4/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "StringEscapeModel.h"

@implementation StringEscapeModel

+ (NSString *)queryAndUrlEscapeText:(NSString *)text {
    
    if (text == nil)
        return @"";
    
    if (text.length == 0)
        return text;
    
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    text = [text stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    
    text = [text stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    text = [text stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
    
    return text;
}

@end
