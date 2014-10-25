//
//  ListViewController.h
//  Note2
//
//  Created by Gemma Ragozzine on 10/15/14.
//  Copyright (c) 2014 Gemma Ragozzine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ListViewController : UITableViewController <NSCoding>
@property (nonatomic) NSMutableArray *noteStrings;

@end
