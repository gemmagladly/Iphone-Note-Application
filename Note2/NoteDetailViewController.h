//
//  NoteDetailViewController.h
//  Note2
//
//  Created by Gemma Ragozzine on 10/15/14.
//  Copyright (c) 2014 Gemma Ragozzine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class NoteDetailViewController;

@protocol NoteDetailViewControllerDelegate <NSObject>

-(void)noteDetailViewController:(NoteDetailViewController *)noteDetailVC
            didFinishWithTitle:(NSString *) text
              didFinishWithBody:(NSString *) content
             didFinishWithIndex: (NSInteger) index
             didFinishWithImage: (UIImage *) image;

@end


@interface NoteDetailViewController: UIViewController<MFMailComposeViewControllerDelegate, UINavigationControllerDelegate>


@property (nonatomic, weak) id<NoteDetailViewControllerDelegate> delegate;

@property (nonatomic) MFMailComposeViewController *mailComposer;

- (instancetype) initWithIndex: (NSInteger) index
                          title: (NSString *) title
                       content: (NSString *) content
                          date: (NSString *) date
                         image: (UIImage *)image;
@end


   
