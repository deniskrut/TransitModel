//
//  PTBaseLoader.h
//  Public Transport Ukraine
//
//  Created by Denis Krut on 21.11.12.
//  Copyright (c) 2012 Denis Krut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTBaseLoader : NSObject
- (NSURL *)url;
- (NSData *)loadURL:(NSURL *)url error:(NSError **)error;
- (id)parseJSON:(NSData *)data error:(NSError **)error;
- (id)parseObject:(id)json error:(NSError **)error;
- (void)startAsyncronously;
- (void)startSyncronously;
- (void)informDelegateAboutSuccessWithObject:(id)res;
- (void)informDelegateAboutFailureWithError:(NSError *)err;
@end
