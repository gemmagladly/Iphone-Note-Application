//
//  NoteInputViewController.m
//  Note2
//
//  Created by Gemma Ragozzine on 10/15/14.
//  Copyright (c) 2014 Gemma Ragozzine. All rights reserved.
//

#import "NoteInputViewController.h"

@interface NoteInputViewController()
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UITextView *textField;
@property (weak, nonatomic) IBOutlet UITextField *titleField;

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@property (nonatomic) UIImage *image;
@property (nonatomic) UIImagePickerController *pickerController;


@end

@implementation NoteInputViewController

-(void) viewDidLoad{
    [super viewDidLoad];
    
    [[self.textField layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[self.textField layer] setBorderWidth:.3];
    [[self.textField layer] setCornerRadius:15];
    
    self.title = @"New Note";
    self.image = nil;
    self.ImageView.image = self.image;
    
    self.pickerController = [[UIImagePickerController alloc] init];
    self.pickerController.allowsEditing = NO;
    self.pickerController.delegate = self;
    self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
}


-(IBAction)doneButtonPressed:(id)sender{
    if([self.titleField.text isEqualToString:@""] || self.titleField.text == nil){
        [self.delegate noteInputViewControllerDidCancel:self];
    }
    else{
        [self.delegate noteInputViewController:self
                            didFinishWithTitle:self.titleField.text didFinishWithBody:self.textField.text didFinishWithImage:self.ImageView.image];
    }
}

- (IBAction)cancelButtonPressed:(id)sender
{
   [self.delegate noteInputViewControllerDidCancel:self];  
}


-(IBAction)addPicturePressed:(id)sender
{
    [self presentViewController:self.pickerController animated:YES completion:nil];
}
- (IBAction)deleteImagePressed:(id)sender
{
    self.image = nil;
    self.ImageView.image = self.image;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    self.ImageView.image = self.image;
}



@end
