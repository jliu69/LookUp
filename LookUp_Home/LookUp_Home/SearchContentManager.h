//
//  SearchContentManager.h
//  LookUp
//
//  Created by Johnson Liu on 10/7/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SearchContentManagerDelegate <NSObject>

@optional
- (void)byContentSearchResults:(NSArray *)list;

@end


@interface SearchContentManager : NSObject

@property (weak, nonatomic) id<SearchContentManagerDelegate> delegate;

- (void)searchByContent:(NSString *)content;

@end
