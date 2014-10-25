//
//  Note.m
//  Note2
//
//  Created by Gemma Ragozzine on 10/22/14.
//  Copyright (c) 2014 Gemma Ragozzine. All rights reserved.
//

#import "Note.h"

@implementation Note

-(instancetype)initWithTitle:(NSString *)title
                        date:(NSString *)date
                     content:(NSString *)content
                       image:(UIImage *)image;
{
    if(self = [super init]){
        self.title = title;
        self.date = date;
        self.content = content;
        self.image = image;
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.image forKey:@"image"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if (self)
    {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
    }
    return self;
}



@end
