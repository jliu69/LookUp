//
//  SearchDateManager.h
//  LookUp
//
//  Created by Johnson Liu on 10/7/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SearchDateManagerDelegate <NSObject>

@optional
- (void)byDateSearchResults:(NSArray *)list;

@end


@interface SearchDateManager : NSObject

@property (weak, nonatomic) id<SearchDateManagerDelegate> delegate;

- (void)searchByDate:(NSString *)dateText;

@end
