//
//  IGRMovieController.h
//  Movies-C
//
//  Created by Ian Richins on 5/8/20.
//  Copyright © 2020 Ian Richins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IGRMovie.h"

NS_ASSUME_NONNULL_BEGIN

@interface IGRMovieController : NSObject

+(void)fetchMovieForSearchTerm: (NSString *)searchTerm completion: (void (^) (NSArray<IGRMovie *> * _Nullable movies)) completion;

+(void)fetchPosterForMovie:(IGRMovie *)movie completion: (void (^)(UIImage * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
