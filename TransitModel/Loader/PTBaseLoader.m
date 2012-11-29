//
//  PTBaseLoader.m
//  Public Transport Ukraine
//
//  Created by Denis Krut on 21.11.12.
//  Copyright (c) 2012 Denis Krut. All rights reserved.
//

#import "PTBaseLoader.h"
#import "JSONKit.h"

@implementation PTBaseLoader
- (NSURL *)url
{
    @throw [NSException exceptionWithName:@"Can't construct url for loading" reason:@"Not implemented" userInfo:nil];
}
- (NSData *)loadURL:(NSURL *)url error:(NSError **)error
{
    NSError *loadingError = nil;
    NSData *result = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:nil error:error];
    if (loadingError) {
        *error = [NSError errorWithDomain:@"Can't load data from server" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Check your internet connection", NSLocalizedDescriptionKey, nil]];
    }
    return result;
}
- (id)parseJSON:(NSData *)data error:(NSError **)error
{
    //check if data set is empty - that means no vehivles for that line
    if ([data length] == 0) {
        //no result
        return nil;
    }
    
    //parse json objects from data
    NSError *parsingError = nil;
    id jsonData = [[JSONDecoder decoder] objectWithData:data error:&parsingError];
    if (parsingError) {
        *error = [NSError errorWithDomain:@"Wrong server output" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Wrong server output", NSLocalizedDescriptionKey, nil]];
    }
    return jsonData;
}
- (id)parseObject:(id)json error:(NSError **)error
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:@"Not implemented" userInfo:nil];
}
- (void)informDelegateAboutSuccessWithObject:(id)res
{
    @throw [NSException exceptionWithName:@"Can't inform delegate" reason:@"Not implemented" userInfo:nil];
}
- (void)informDelegateAboutFailureWithError:(NSError *)err
{
    @throw [NSException exceptionWithName:@"Can't inform delegate" reason:@"Not implemented" userInfo:nil];
}
- (void)startSyncronously
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSError *error = nil;
    NSData *data = [self loadURL:[self url] error:&error];
    if (error) {
        [self informDelegateAboutFailureWithError:error];
        [pool release];
        return;
    }
    
    id json = [self parseJSON:data error:&error];
    if (error) {
        [self informDelegateAboutFailureWithError:error];
        [pool release];
        return;
    }
    
    id resObject = [self parseObject:json error:&error];
    if (error) {
        [self informDelegateAboutFailureWithError:error];
        [pool release];
        return;
    }
    
    [self informDelegateAboutSuccessWithObject:resObject];
    [pool release];
}
- (void)startAsyncronously
{
    if ([[NSThread currentThread] isMainThread])
        [self performSelectorInBackground:@selector(startSyncronously) withObject:nil];
    else
        [self performSelector:@selector(startSyncronously)];
}
@end
