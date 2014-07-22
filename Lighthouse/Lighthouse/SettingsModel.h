//
//  SettingsModel.h
//  Lighthouse
//
//  Created by Timothy Figura on 7/21/14.
//  Copyright (c) 2014 Timothy Figura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsModel : NSObject

-(NSString *) sha1:(NSString*)input;
-(BOOL) login:(NSString*)username password:(NSString *)password server:(NSString *)server;

@end
