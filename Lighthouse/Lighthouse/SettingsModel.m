//
//  SettingsModel.m
//  Lighthouse
//
//  Created by Timothy Figura on 7/21/14.
//  Copyright (c) 2014 Timothy Figura. All rights reserved.
//

#import "SettingsModel.h"
#import <CommonCrypto/CommonDigest.h>

@implementation SettingsModel


-(NSString *) sha1:(NSString*)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:[input lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",digest[i]];
    
    return output;
}

-(BOOL) login:(NSString*)username password:(NSString *)password server:(NSString *)server
{
    
    NSString *tempserver;
    NSString *path;
    
    tempserver = server;
    
    path = [NSString stringWithFormat:@"http://%@/iphonelogin.php?USER=%@",server,username];
    
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    NSURLResponse * response = nil;
    NSError * error = nil;
    
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    if (error == nil)
    {
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        
            NSDictionary *jsonElement = jsonArray[0];
            NSString *returnedvalue = [[NSString alloc] init];
            returnedvalue = jsonElement[@"UserPassword"];
        
        if ([password isEqualToString:returnedvalue])
        {
            //Password correct
            NSLog(@"Success");
            return YES;
        }
        else
        {
            //Password wrong
            NSLog(@"Password Wrong");
            return NO;
        }
            
       
    }
    return NO;
}


@end
