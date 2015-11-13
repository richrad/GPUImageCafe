//
//  SWAPIClient.m
//  Surfwave
//
//  Created by masafumi yoshida on 2014/06/18.
//  Copyright (c) 2014年 masafumi yoshida. All rights reserved.
//

#import "GUCAPIClient.h"
#import <AFNetworking.h>

@interface GUCAPIClient ()
@property(nonatomic) AFHTTPRequestOperationManager*client;

@end
@implementation GUCAPIClient


-(id)init{
    self = [super init];
    if(self){
        NSURL *url = [NSURL URLWithString:@"https://raw.githubusercontent.com/"];
        self.client = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        self.client.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"text/plain", nil];
    }
    return self;
}

-(void)filter:(GUCAPIClientCompleteBlocks)complete{
    
#ifdef DEBUG
        NSError *error;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"filter" ofType:@"json"];
        NSString *jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error: &error];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUnicodeStringEncoding];
       
        if(error){
            NSLog(@"failed load json data");
            complete(nil,error);
            return;
        }
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];
        if(error){
            NSLog(@"failed load json");
            
        }
        complete(array,error);
        return;
#endif
    
    
   
    
    [[self client] GET:@"/nyankichi820/GPUImageCafe/master/Resources/filter.json"
            parameters:nil
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   complete(responseObject,nil);
                   
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   complete(nil,error);
               }];
    
    
}



@end
