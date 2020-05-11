//
//  IGRMovieController.m
//  Movies-C
//
//  Created by Ian Richins on 5/8/20.
//  Copyright © 2020 Ian Richins. All rights reserved.
//

#import "IGRMovieController.h"
#import "IGRMovie.h"

static NSString *const kBaseURLString = @"https://api.themoviedb.org/3/";
static NSString *const kPosterBaseUrL = @"https://image.tmdb.org/t/p/w500";
static NSString *const kMovieComponent = @"search/movie";
static NSString *const QueryKey = @"query";
static NSString *const apiKey = @"api_key";
static NSString *const apiValue = @"e84b73284ae647705c1f95baa71965dc";
static NSString *const kResultsKey = @"results";

@implementation IGRMovieController

+ (void)fetchMovieForSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray<IGRMovie *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:kBaseURLString];
    NSURL *movieURL = [baseURL URLByAppendingPathComponent:kMovieComponent];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:movieURL resolvingAgainstBaseURL:true];
    
    NSURLQueryItem *movieQueryItem = [NSURLQueryItem queryItemWithName:QueryKey value:searchTerm];
    NSURLQueryItem *apiQueryItem = [NSURLQueryItem queryItemWithName:apiKey value:apiValue];
    
    urlComponents.queryItems = @[movieQueryItem, apiQueryItem];
    
    NSURL *finalURL = urlComponents.URL;
    
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (error)
           {
               NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
               completion(nil);
               return;
           }
           
           if (response)
           {
               NSLog(@"%@", response);
           }
    if (!data)
    {
        NSLog(@"Error: no data was returned on the data task");
        completion(nil);
        return;
    }
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
        
        if (!topLevelDictionary || ![topLevelDictionary isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"unable to create a dictionary from the data");
            completion(nil);
            return;
        }
        
        NSArray *movieArray = topLevelDictionary[kResultsKey];
        
        NSMutableArray *moviePlaceholder = [NSMutableArray array];
        
        for (NSDictionary *movieDictionary in movieArray)
        {
            IGRMovie *movie = [[IGRMovie alloc] initWithDictionary:movieDictionary];
            [moviePlaceholder addObject:movie];
        }
        completion(moviePlaceholder);
    
    }]resume];
}

+ (void)fetchPosterForMovie:(IGRMovie *)movie completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *posterURL = [NSURL URLWithString:kPosterBaseUrL];
    
    NSString *posterPath = movie.poster;
    
    NSURL *posterFinalURL = [posterURL URLByAppendingPathComponent:posterPath];
    
    NSLog(@"%@", posterFinalURL);
    
    [[NSURLSession.sharedSession dataTaskWithURL:posterFinalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (error)
               {
                   NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
                   completion(nil);
                   return;
               }
               
               if (response)
               {
                   NSLog(@"%@", response);
               }
        if (!data)
        {
            NSLog(@"Error: no data was returned on the data task");
            completion(nil);
            return;
        }
    
        UIImage *posterImage = [UIImage imageWithData:data];
        completion(posterImage);
     
        }]resume];
}


@end
