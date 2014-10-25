//
//  NoteInputViewController.h
//  Note2
//
//  Created by Gemma Ragozzine on 10/15/14.
//  Copyright (c) 2014 Gemma Ragozzine. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NoteInputViewController;

@protocol NoteInputViewControllerDelegate <NSObject>

-(void)noteInputViewController:(NoteInputViewController *)noteInVC
             didFinishWithTitle:(NSString *) text
             didFinishWithBody:(NSString *) content
            didFinishWithImage:(UIImage *)image;

-(void)noteInputViewControllerDidCancel: (NoteInputViewController *)noteInVC;

@end

@interface NoteInputViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) id<NoteInputViewControllerDelegate> delegate;

@end