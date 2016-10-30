//
//  SearchNameManager.h
//  LookUp
//
//  Created by Johnson Liu on 10/7/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SearchNameManagerDelegate <NSObject>

@optional
- (void)byNameSearchResults:(NSArray *)list;

@end


@interface SearchNameManager : NSObject

@property (weak, nonatomic) id<SearchNameManagerDelegate> delegate;

- (void)searchByName:(NSString *)name;

@end
