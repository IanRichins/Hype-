//
//  IGRMovie.h
//  Movies-C
//
//  Created by Ian Richins on 5/8/20.
//  Copyright © 2020 Ian Richins. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface IGRMovie : NSObject

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *overview;
@property (nonatomic, readonly, copy) NSString *poster;
@property (nonatomic, readonly) NSInteger rating;


- (instancetype) initWithMovieTitle: (NSString *)title
                           overview: (NSString *)overview
                             poster: (NSString *)poster
                             rating: (NSInteger)rating;

-(instancetype) initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;


@end

NS_ASSUME_NONNULL_END


