//
//  Note.h
//  Note2
//
//  Created by Gemma Ragozzine on 10/22/14.
//  Copyright (c) 2014 Gemma Ragozzine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Note : NSObject <NSCoding>

@property NSString *title;

@property NSString *content;

@property NSString *date;

@property UIImage *image;

-(instancetype)initWithTitle:(NSString *)title
                        date:(NSString *)date
                     content:(NSString *)content
                       image:(UIImage *) image;

@end