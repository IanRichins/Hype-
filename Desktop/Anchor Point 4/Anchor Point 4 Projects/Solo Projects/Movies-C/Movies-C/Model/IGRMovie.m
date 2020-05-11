//
//  IGRMovie.m
//  Movies-C
//
//  Created by Ian Richins on 5/8/20.
//  Copyright © 2020 Ian Richins. All rights reserved.
//

#import "IGRMovie.h"

static NSString *const kTitleKey = @"title";
static NSString *const kPosterKey = @"poster_path";
static NSString *const kOverviewKey = @"overview";

@implementation IGRMovie
- (instancetype)initWithMovieTitle:(NSString *)title overview:(NSString *)overview poster:(NSString *)poster rating:(NSInteger)rating
{
    self = [super init];
    if (self)
    {
        _title = title;
        _overview = overview;
        _poster = poster;
        _rating = rating;
    }
    return self;
}
- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
{
    NSString *title = dictionary[kTitleKey];
    NSString *overview = dictionary[kOverviewKey];
    NSString *poster = dictionary[kPosterKey];
    NSInteger rating = [dictionary[@"vote_average"] intValue];
    
    return [self initWithMovieTitle:title overview:overview poster:poster rating:rating];
}
@end
